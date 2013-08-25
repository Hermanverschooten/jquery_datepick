require 'date'

module JqueryDatepick
  module FormHelper
    
    include ActionView::Helpers::JavaScriptHelper

    # Mehtod that generates datepicker input field inside a form
    def datepicker(object_name, method, options = {})
      options.delete(:object) if options[:object]
      input_tag =  JqueryDatepick::InstanceTag.new(object_name, method, self, options)
      dp_options, tf_options =  input_tag.split_options(options)
      tf_options[:value] = input_tag.format_date(tf_options[:value], String.new(dp_options[:dateFormat])) if  tf_options[:value] && !tf_options[:value].empty? && dp_options.has_key?(:dateFormat)
      html= if defined?(ActionView::Helpers::InstanceTag) && ActionView::Helpers::InstanceTag.instance_method(:initialize).arity != 0
        input_tag.to_input_field_tag("text", tf_options)
      else
        ActionView::Helpers::Tags::TextField.new(object_name, method, tf_options).render
      end

      html += javascript_tag("jQuery(document).ready(function(){jQuery('##{input_tag.get_name_and_id["id"]}').datepick($.extend(#{dp_options.to_json},$.datepick.regional['#{I18n.locale}']))});")
      html.html_safe
    end
    
  end

end

module JqueryDatepick::FormBuilder
  def datepicker(method, options = {})
    @template.datepicker(@object_name, method, objectify_options(options))
  end
end

module JqueryDatepick_instance

  FORMAT_REPLACEMENTES = { "yy" => "%Y", "mm" => "%m", "dd" => "%d", "d" => "%-d", "m" => "%-m", "y" => "%y", "M" => "%b"}
  
  # Extending ActionView::Helpers::InstanceTag module to make Rails build the name and id
  # Just returns the options before generate the HTML in order to use the same id and name (see to_input_field_tag mehtod)
  
  def get_name_and_id(options = {})
    add_default_name_and_id(options)
    options
  end
  
  def available_datepicker_options
    [:disabled, :altField, :altFormat, :appendText, :autoSize, :buttonImage, :buttonImageOnly, :buttonText, :calculateWeek, :changeMonth, :changeYear, :closeText, :constrainInput, :currentText, :dateFormat, :dayNames, :dayNamesMin, :dayNamesShort, :defaultDate, :duration, :firstDay, :gotoCurrent, :hideIfNoPrevNext, :isRTL, :maxDate, :minDate, :monthNames, :monthNamesShort, :navigationAsDateFormat, :nextText, :numberOfMonths, :prevText, :selectOtherMonths, :shortYearCutoff, :showAnim, :showButtonPanel, :showCurrentAtPos, :showMonthAfterYear, :showOn, :showOptions, :showOtherMonths, :showWeek, :stepMonths, :weekHeader, :yearRange, :yearSuffix]
  end
  
  def split_options(options)
    tf_options = options.slice!(*available_datepicker_options)
    return options, tf_options
  end
  
  def format_date(tb_formatted, format)
    new_format = translate_format(format)
    Date.parse(tb_formatted).strftime(new_format)
  end

  # Method that translates the datepicker date formats, defined in (http://docs.jquery.com/UI/Datepicker/formatDate)
  # to the ruby standard format (http://www.ruby-doc.org/core-1.9.3/Time.html#method-i-strftime).
  # This gem is not going to support all the options, just the most used.
  
  def translate_format(format)
    format.gsub!(/#{FORMAT_REPLACEMENTES.keys.join("|")}/) { |match| FORMAT_REPLACEMENTES[match] }
  end
end


if defined?(ActionView::Helpers::InstanceTag) && ActionView::Helpers::InstanceTag.instance_method(:initialize).arity != 0
class JqueryDatepick::InstanceTag < ActionView::Helpers::InstanceTag
    include JqueryDatepick_instance
  end
else
  class JqueryDatepick::InstanceTag < ActionView::Helpers::Tags::Base
    include JqueryDatepick_instance
  end
end
