jQuery ->

  # Form helpers for rendering form errors
  $.fn.render_form_errors = (model_name, errors) ->
    form = this
    this.clear_form_errors()

    $.each(errors, (field, messages) ->
      input = form.find('input,select,textarea').filter("[name*='#{field}']").first()
      input.addClass('invalid')

      $('.item-errors .card-panel ul')
        .append("<li class='#{model_name}_#{field}'>#{field.capitalize()} #{messages.join(' and ')}</li>")\
        .parents('.item-errors')
        .slideDown 500
    )


  $.fn.clear_all_form_errors = () ->
    $(this)
      .find('input,select,textarea')
      .removeClass('invalid');

    $('.item-errors')
      .slideUp 500, ->
        $(this)
          .find('.card-panel ul li')
          .remove();



  $.fn.clear_form_errors = () ->
    lnk = this
    errors_panel = lnk.parents('form').find('.item-errors')
    lnk
      .removeClass('invalid');

    if errors_panel.find('ul li').length <= 1
      errors_panel
        .slideUp 300, ->
          errors_panel
            .find(".card-panel ul li.#{lnk.attr('id')}")
            .remove();



  $.fn.clear_form_fields = () ->
    this.find(':input','#myform')
      .not(':button, :submit, :reset, :hidden')
      .val('')
      .removeAttr('checked')
      .removeAttr('selected')

  String.prototype.capitalize = () ->
    str = this.replace('_', ' ')
    str.charAt(0).toUpperCase() + str.slice(1);
