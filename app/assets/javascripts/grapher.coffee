jQuery ->
  $.fn.statsGraph = (el, data) ->
    current_loc = _.first(data)
    location_changes = [current_loc]
    _.each data, (record,i) ->
      if record['location'] != current_loc['location']
        location_changes.push(record)
        current_loc = record

    config = {
      title: {
        text: 'Gold/Points Progress',
        x: -20 # center
      },
      chart: { zoomType: 'x' },
      xAxis: { type: 'datetime' },
      yAxis: [{
        title: { text: 'Gold'}
      },{
        title: { text: 'Points'}
        opposite: true
      }],
      legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle',
        borderWidth: 0
      }
      plotOptions:{
        scatter: {
          dataLabels: {
            useHTML: true,
            enabled: true,
            allowOverlap: true,
            y: 15,
            x: 0,
            formatter: ->
              return "<div class='location-image' style='background-image:url(/location_images/#{this.point.className}.jpg)'></div>"
          }
        }
      },
      series: [{
        name: 'Gold',
        yAxis: 0,
        type: 'spline',
        color: '#ffb300',
        data: _.map data, (point) ->
          return [point.created_js_time, point.gold]
      },{
        name: 'Points',
        yAxis: 1,
        type: 'spline',
        color: '#0277bd',
        data: _.map data, (point) ->
          return [point.created_js_time, point.points]
      },{
        type: 'scatter',
        showInLegend: false,
        yAxis: 1,
        tooltip: {
          headerFormat: '',
          pointFormatter: ->
            return "<b>#{this.name}</b>"
        },
        data: _.map location_changes, (pnt) ->
          return {
            name: pnt.location,
            className: pnt.location_image,
            x: pnt.created_js_time,
            y: pnt.points,
            marker: {
              symbol: 'square',
              radius: 1
            }
          }

      }]
    }

    Highcharts.chart(el, config);

  $.fn.normalMiceGraph = (el, data) ->
    current_loc = _.first(data)
    location_changes = [current_loc]
    _.each data, (record,i) ->
      if record['location'] != current_loc['location']
        location_changes.push(record)
        current_loc = record

    config = {
      title: {
        text: 'Breeds Caught',
        x: -20 # center
      },
      chart: { zoomType: 'x' },
      xAxis: { type: 'datetime' },
      yAxis: {
        title: { text: 'Breeds Caught'},
      },
      legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle',
        borderWidth: 0
      }
      plotOptions:{
        scatter: {
          dataLabels: {
            useHTML: true,
            enabled: true,
            allowOverlap: true,
            y: 15,
            x: 0,
            formatter: ->
              return "<div class='location-image' style='background-image:url(/location_images/#{this.point.className}.jpg)'></div>"
          }
        }
      },
      series: [{
        name: 'Breeds Caught',
        type: 'spline',
        color: '#33691e',
        data: _.map data, (point) ->
          return [point.created_js_time, point.breeds_caught]
      },{
        name: 'Total Breeds',
        type: 'line',
        color: '#9ccc65',
        enableMouseTracking: false,
        data: _.map data, (point) ->
          return [point.created_js_time, point.breeds_total]
      },{
        type: 'scatter',
        showInLegend: false,
        tooltip: {
          headerFormat: '',
          pointFormatter: ->
            return "<b>#{this.name}</b>"
        },
        data: _.map location_changes, (pnt) ->
          return {
            name: pnt.location,
            className: pnt.location_image,
            x: pnt.created_js_time,
            y: pnt.breeds_caught,
            marker: {
              symbol: 'square',
              radius: 1
            }
          }

      }]
    }

    Highcharts.chart(el, config);

  $.fn.eventMiceGraph = (el, data) ->
    current_loc = _.first(data)
    location_changes = [current_loc]
    _.each data, (record,i) ->
      if record['location'] != current_loc['location']
        location_changes.push(record)
        current_loc = record

    config = {
      title: {
        text: 'Event Breeds Caught',
        x: -20 # center
      },
      chart: { zoomType: 'x' },
      xAxis: { type: 'datetime' },
      yAxis: {
        title: { text: 'Event Breeds Caught'},
      },
      legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle',
        borderWidth: 0
      }
      plotOptions:{
        scatter: {
          dataLabels: {
            useHTML: true,
            enabled: true,
            allowOverlap: true,
            y: 15,
            x: 0,
            formatter: ->
              return "<div class='location-image' style='background-image:url(/location_images/#{this.point.className}.jpg)'></div>"
          }
        }
      },
      series: [{
        name: 'Event Breeds Caught',
        type: 'spline',
        color: '#4527a0',
        data: _.map data, (point) ->
          return [point.created_js_time, point.event_breeds_caught]
      },{
        name: 'Total Breeds',
        type: 'line',
        color: '#7e57c2',
        enableMouseTracking: false,
        data: _.map data, (point) ->
          return [point.created_js_time, point.event_breeds_total]
      },{
        type: 'scatter',
        showInLegend: false,
        tooltip: {
          headerFormat: '',
          pointFormatter: ->
            return "<b>#{this.name}</b>"
        },
        data: _.map location_changes, (pnt) ->
          return {
            name: pnt.location,
            className: pnt.location_image,
            x: pnt.created_js_time,
            y: pnt.event_breeds_caught,
            marker: {
              symbol: 'square',
              radius: 1
            }
          }

      }]
    }

    Highcharts.chart(el, config);

  teamColors = ['#1D78B4','#33A02C','#E31A1C','#FF7F00','#6A3D9A','#8C510A','#A6CEE3','#B2DF8A','#FB9A99','#FDBF6F','#CAB2D6','#E6AB00']

  $.fn.teamPointsGraph = (el, data) ->
    config = {
      title: {
        text: 'Team Points Progress',
        x: -20 # center
      },
      chart: { zoomType: 'xy' },
      xAxis: { type: 'datetime' },
      yAxis: {
        title: { text: 'Points'}
      },
      legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle',
        borderWidth: 0
      }
      series: _.map data, (hunter, index) ->
        return {
          type: 'spline'
          name: hunter.name,
          color: teamColors[index],
          data: _.map hunter.records, (point) ->
            return [point.created_js_time, point.points]
        }
    }

    Highcharts.chart(el, config);

  $.fn.teamGoldGraph = (el, data) ->
    config = {
      title: {
        text: 'Team Gold Progress',
        x: -20 # center
      },
      chart: { zoomType: 'xy' },
      xAxis: { type: 'datetime' },
      yAxis: {
        title: { text: 'Gold'}
      },
      legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle',
        borderWidth: 0
      }
      series: _.map data, (hunter, index) ->
        return {
          type: 'spline'
          name: hunter.name,
          color: teamColors[index],
          data: _.map hunter.records, (point) ->
            return [point.created_js_time, point.gold]
        }
    }

    Highcharts.chart(el, config);


  $.fn.teamBreedsCaughtGraph = (el, data) ->
    series = _.map data, (hunter, index) ->
      return {
        type: 'spline'
        name: hunter.name,
        color: teamColors[index],
        data: _.map hunter.records, (point) ->
          return [point.created_js_time, point.breeds_caught]
      }

    series.push {
      name: 'Total Breeds',
      type: 'line',
      color: '#000',
      enableMouseTracking: false,
      data: _.map data[0].records, (point) ->
        return [point.created_js_time, point.breeds_total]
    }

    config = {
      title: {
        text: 'Team Breeds Caught',
        x: -20 # center
      },
      chart: { zoomType: 'x' },
      xAxis: { type: 'datetime' },
      yAxis: {
        title: { text: 'Breeds Caught'},
      },
      legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle',
        borderWidth: 0
      }
      series: series
    }

    Highcharts.chart(el, config);

  $.fn.teamEventBreedsCaughtGraph = (el, data) ->
    series = _.map data, (hunter, index) ->
      return {
        type: 'spline'
        name: hunter.name,
        color: teamColors[index],
        data: _.map hunter.records, (point) ->
          return [point.created_js_time, point.event_breeds_caught]
      }

    series.push {
      name: 'Total Event Breeds',
      type: 'line',
      color: '#000',
      enableMouseTracking: false,
      data: _.map data[0].records, (point) ->
        return [point.created_js_time, point.event_breeds_total]
    }

    config = {
      title: {
        text: 'Team Event Breeds Caught',
        x: -20 # center
      },
      chart: { zoomType: 'x' },
      xAxis: { type: 'datetime' },
      yAxis: {
        title: { text: 'Breeds Caught'},
      },
      legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle',
        borderWidth: 0
      }
      series: series
    }

    Highcharts.chart(el, config);
