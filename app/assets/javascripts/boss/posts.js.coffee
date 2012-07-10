$ ->
  redactor =
    init: ->
      $('#redactor_content').redactor({ 
        fixed: true,                               # toolbar goes to top as user scrolls
        autoresize: true,                          # textarea resizes automatically as user types
        focus: true,                               # gets focus on load
        imageUpload: '/resources/image',           # upload images from pc
        imageGetJson: '/resources/images.json',    # gallery to choose from
        fileUpload: '/resources/file'              # upload files from pc
      })

  redactor.init()