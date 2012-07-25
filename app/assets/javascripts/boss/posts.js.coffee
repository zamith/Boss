$ ->
  redactor =
    container: $('#redactor-content')

    edit: ->
      if redactor.container.attr('class') and redactor.container.attr('class').indexOf("edit") != -1
        $.get window.location.href.replace("edit","content"), (data) ->
          redactor.container.setCode(data) 

    publish: ->
      $("#publish").on 'click', ->
        $(this).find("#data").attr('value', redactor.container.getCode())
        $(this).find("#title").attr('value', $("#post-title").attr("value"))

    save: ->
      $('#save').on 'click', (event) ->
        $.post "/posts/save", { data: redactor.container.getCode(), title: $("#post-title").attr("value") }, (data) ->
          window.location.href = data.redirect if data.redirect
        event.preventDefault()

    init: ->
      redactor.container.redactor({
        fixed: true,                               # toolbar goes to top as user scrolls
        autoresize: true,                          # textarea resizes automatically as user types
        focus: true,                               # gets focus on load
        imageUpload: '/resources/image',           # upload images from pc
        imageGetJson: '/resources/images.json',    # gallery to choose from
        fileUpload: '/resources/file',             # upload files from pc
        observeImages: true,                       # change image settings
        autosave: '/posts/save',                   # autosave
        interval: 60                               # autosave interval in seconds
      })
      redactor.edit()
      redactor.save()
      redactor.publish()

  redactor.init()