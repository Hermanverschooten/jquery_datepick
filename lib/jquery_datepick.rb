require "jquery_datepick/version"
require "jquery_datepick/datepick_helper.rb"
require "jquery_datepick/form_helper.rb"

module JqueryDatepick
  class Engine < ::Rails::Engine
  end
  class Railtie < Rails::Railtie
    initializer "JqueryDatepick" do
      ActionController::Base.helper(JqueryDatepick::DatepickHelper)
      ActionView::Helpers::FormHelper.send(:include, JqueryDatepick::FormHelper)
      ActionView::Base.send(:include, JqueryDatepick::DatepickHelper)
      ActionView::Helpers::FormBuilder.send(:include,JqueryDatepick::FormBuilder)
    end
  end
end
