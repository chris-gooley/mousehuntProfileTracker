$ ->
  $.rails.allowAction = (link) ->
    return true  unless link.attr("data-confirm")
    $.rails.showConfirmDialog link
    false

  $.rails.confirmed = (link) ->
    link.removeAttr "data-confirm"
    link.trigger "click.rails"

  $.rails.showConfirmDialog = (link) ->
    html = undefined
    message = undefined
    message = link.attr("data-confirm")
    html = "<div id=\"modal1\" class=\"modal\" style=\"z-index: 1003; display: block; opacity: 1; transform: scaleX(1); top: 10%;\"> <div class=\"modal-content\"><h4>" + message + "</h4></div><div class=\"modal-footer\"><a class=\"modal-action modal-close waves-effect waves-red btn-flat close\">Cancel</a><a class=\"modal-action modal-close waves-effect waves-green btn-flat confirm\">OK</a></div></div>"
    $("body").append html
    $("#modal1").openModal complete: ->
      $("#modal1").remove()

    return $("#modal1 .confirm").on("click", ->
      $.rails.confirmed link
    )
    $("#modal1 .close").on "click", ->
      $("#modal1").closeModal()
