module ApplicationHelper

  def flash_messages
    messages = ''

    types = {
      notice: 'light-blue lighten-1',
      alert: 'red lighten-1'
    }

    types.each do |type, attributes|
      if flash[type].present?
        flash_message = flash.discard(type)

        messages << render( partial: "layouts/alert", locals: { message: flash_message, flash_class: attributes } )
      end
    end

    messages.html_safe
  end

end
