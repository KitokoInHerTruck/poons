# frozen_string_literal: true

module SolidusAcmeFulfillment
  class Configuration
    # Define here the settings for this extension, e.g.:
    #
    # attr_accessor :my_setting
    attr_accessor :api_key
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    alias config configuration

    def configure
      yield configuration
    end
  end
end
