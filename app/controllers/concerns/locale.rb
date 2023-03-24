module Spree
  module Core
    module ControllerHelpers
      module Locale
        extend ActiveSupport::Concern

        included do
          before_action :set_locale
        end

        private

        def set_locale
          I18n.locale = session[:locale] || I18n.default_locale
        end
      end
    end
  end
end