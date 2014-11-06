class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @transactions = Transaction.all
    respond_with(@transactions)
  end

  def show
    respond_with(@transaction)
  end

  def new
    @property = Property.find(params[:property_id])
    @transaction = Transaction.new
    respond_with(@transaction)
  end

  def edit
  end

  def create
    @property = Property.find(params[:property_id])
    @transaction = @property.transactions.create(transaction_params)
    respond_to do |format|
      if @transaction.save
        flash[:notice] = 'Transaction was successfully created.'
        format.html { redirect_to(@transaction.property) }
        format.json { render xml: @transaction }
      else
        format.html { render action: "new" }
        format.json { render xml: @transaction }
      end
    end
  end

  def update
    @transaction.update(transaction_params)
    respond_with(@transaction)
  end

  def destroy
    @transaction.destroy
    respond_to do |format|
      if @transaction.save
        flash[:notice] = 'Transaction was successfully deleted.'
        format.html { redirect_to(@transaction.property) }
        format.json { render xml: @transaction }
      else
        format.html { render action: "new" }
        format.json { render xml: @transaction }
      end
    end
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:income_type, :outgoing, :value, :fequency, :last_due, :property_id)
    end
end
