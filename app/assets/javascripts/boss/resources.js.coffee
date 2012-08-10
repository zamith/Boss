$ ->
  resource_upload =
    init: ->
      $("#fileupload").fileupload {
        autoUpload: false,
        dropZone: $("#filedrag"),
      }

  resource_upload.init()