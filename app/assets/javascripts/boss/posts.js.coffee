$ ->
  redactor =
    publish: ->
      $("#publish").on 'click', ->
        $(this).find("#data").attr('value', $('#redactor-content').getCode())

    save: ->
      $('#save').on 'click', (event) ->
        $.post "/posts/save", { data: $('#redactor-content').getCode() }
        event.preventDefault()

    init: ->
      $('#redactor-content').redactor({ 
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
      redactor.save()
      redactor.publish()

  redactor.init()