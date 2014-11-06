

function getPaymentFrequency(repayment_frequency) {
  if (repayment_frequency == "weekly") {
    return 52;
  } else if (repayment_frequency == "fortnightly") {
    return 26;
  } else {
    return 12;
  }
}

function getRepaymentDetails(balance, frequency, loan_term, rates) {
  var periods = loan_term * frequency;
  var rate = (rates / 100) / frequency;
  var payment = (rate / (1 - (Math.pow((1 + rate), -(periods))))) * balance;

  var balances = [];
  var dates = [0];
  var total_payments = 0;
  for (var i = 0; i < periods; i++) {
    var interestForMonth = balance * rate;
    var principalForMonth = payment - interestForMonth;
    balance -= principalForMonth;
    total_payments += payment;
    if(i % frequency == 0) {
      balances.push(balance);
      dates.push(dates[dates.length-1] + 1);
    }

  }
  return {balances: balances, dates: dates, payment: payment, total_payments: total_payments};
}

var appendSeries = function(series, name, data) {
  series.push({
    type: 'line',
    name: name,
    data: data.balances
  });
  $(".portfolio_description").append("<div class='row'><div class='col-md-7'>"+name+":</div><div class='col-md-5'><span class='currency'>"+data.total_payments.toFixed(0)+"</span></div></div>");

  return series;
}

var chart = function(id) {
  var container = $("#graph_container");
    $.getJSON(container.data('charturl'), function (data) {
      var series = [];
      $('.row', ".portfolio_description").remove();

      var userRepaymentDetails = getRepaymentDetails(data.user_home_loan.amount, getPaymentFrequency(data.user_home_loan.repayment_frequency), data.user_home_loan.loan_term, data.user_home_loan_rates);
      appendSeries(series, data.user_home_loan.name, userRepaymentDetails);

      if(data.bank_rates) {
        var bankRepaymentDetails = getRepaymentDetails(data.user_home_loan.amount, getPaymentFrequency(data.user_home_loan.repayment_frequency), data.user_home_loan.loan_term, data.bank_rates);
        appendSeries(series, "Advertised rate", bankRepaymentDetails);
      }

      var lowestBankRepaymentDetails = getRepaymentDetails(data.user_home_loan.amount, getPaymentFrequency(data.user_home_loan.repayment_frequency), data.user_home_loan.loan_term, data.lowest_rate_home_loan.rate);
      appendSeries(series, "Lowest Bank", lowestBankRepaymentDetails);

      $(".currency").formatCurrency({roundToDecimalPlace: 0});

      new Highcharts.Chart({
        chart: {
          renderTo: container.attr('id')
        },
        title: {
          text: 'Home Loan'
        },
        xAxis: {
          categories: userRepaymentDetails.dates
        },
        series: series
      });
    });
}

var ready = function() {

  $("[data-remote=true]").on("ajax:success", function(ev, data, status, xhr) {
    chart($(ev.target).data("id"));
  }).on("ajax:error", function(e, data, status, xhr) {
    // do nothing atm
  });
}
$(document).ready(ready);
$(document).on('page:load', ready);