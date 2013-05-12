require 'jquery_datepick/form_helper'

module JqueryDatepick
  module DatepickHelper

    include JqueryDatepick::FormHelper

    # Helper method that creates a datepicker input field
    def datepicker_input(object_name, method, options = {})
      datepicker(object_name, method, options)
    end
    
    def datetime_picker_input(object_name, method, options = {})
      datepicker(object_name, method, options, true)
    end
  
  end
end