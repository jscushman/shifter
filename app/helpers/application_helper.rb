module ApplicationHelper
  def bootstrap_class_for flash_type
    { "success" => "alert-success", "error" => "alert-danger", "alert" => "alert-warning", "notice" => "alert-info" }[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end
end

module ActionView
  module Helpers
    class FormBuilder 
      def date_select(method, options = {}, html_options = {})
        existing_date = @object.send(method) 
        formatted_date = existing_date.to_date.strftime("%F") if existing_date.present?
        @template.content_tag(:div, :class => "input-group") do    
          text_field(method, {:value => "", :class => "form-control datepicker", :"data-date-format" => "MMMM DD, YYYY"}.merge(html_options)) +
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
        end
      end

      def datetime_select(method, options = {}, html_options = {})
        existing_time = @object.send(method) 
        formatted_time = existing_time.to_time.strftime("%F %I:%M %p") if existing_time.present?
        @template.content_tag(:div, :class => "input-group") do    
          text_field(method, {:value => "", :class => "form-control datetimepicker", :"data-date-format" => "YYYY-MM-DD hh:mm A"}.merge(html_options)) +
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
        end
      end
    end
  end
end
