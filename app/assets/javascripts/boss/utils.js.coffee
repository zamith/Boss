$ ->
  window.Utils = {}

  Utils.setDatepickerWithTime = (time) ->
    counter = 0
    locale = ""
    for i in $.datepicker.regional
      if (counter == 1)
       locale = i
       break
      counter++
    $.datepicker.setDefaults($.datepicker.regional[locale])
    if(time)
      $(".datepicker").datetimepicker()
    else
      $(".datepicker").datepicker
        dateformat: "dd-mm-yyyy"