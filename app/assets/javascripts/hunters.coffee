# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('ul.tabs').tabs {
    onShow: (e) ->
      el = e.selector;
      console.log(el)

      switch(el)
        when "#progress"
          $('footer').hide()
          $.ajax {
            url: '/hunter/progress',
            dataType: 'json',
            success: (data, status, jqXHR) ->
              $.fn.statsGraph('stats-graph', data)
              $.fn.normalMiceGraph('normal-mice-graph', data)
              $.fn.eventMiceGraph('event-mice-graph', data)
              $('footer').show()

          }
        when "#team"
          $('footer').hide()
          $.ajax {
            url: '/hunter/team',
            dataType: 'json',
            success: (data, status, jqXHR) ->
              $.fn.teamPointsGraph('team-points-graph', data)
              $.fn.teamGoldGraph('team-gold-graph', data)
              #$.fn.teamMiceGraph('team-mice-graph', data)
              $.fn.teamBreedsCaughtGraph('team-mice-graph', data)
              $.fn.teamEventBreedsCaughtGraph('team-event-mice-graph', data)
              $('footer').show()
          }

  }

  $(document).on("ajax:error", "#signup-form", (e, data, status, xhr) ->
    $('#signup-form').clear_all_form_errors();
    $("#signup-form").render_form_errors('hunter', JSON.parse(data.responseText))
  )

$(document).on 'ready turbolinks:load', ->
  s = window.location.hash.substr(1);
  switch (s)
    when 'progress'
      $('ul.tabs').tabs('select_tab', 'progress');
    when 'team'
      $('ul.tabs').tabs('select_tab', 'team');



  Materialize.updateTextFields();



