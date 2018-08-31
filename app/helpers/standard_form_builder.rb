class StandardFormBuilder < ActionView::Helpers::FormBuilder

  def text_field(method, options = {})
    if @object.errors.present? and @object.errors.messages.keys.include?(method)
      options[:class] = options[:class].present? ? "#{options[:class]} invalid" : "invalid"
    end

    @template.text_field(@object_name, method, options)
  end
end
