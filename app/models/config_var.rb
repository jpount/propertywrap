class ConfigVar < ActiveRecord::Base

  CONFIG_TYPE = [:oauth_key]
  OAUTH = "oauth_key"

  validates_presence_of :config_type, :config_value

end
