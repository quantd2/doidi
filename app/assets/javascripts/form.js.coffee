validateUploadedFileType = ($el) ->
  $this = $el
  size = $this[0].files[0].size
  result = true
  $this.parent().find(".image.help-block").remove()
  fileExtension = [
    'jpeg'
    'jpg'
    'png'
    'gif'
  ]
  if $.inArray($this.val().split('.').pop().toLowerCase(), fileExtension) == -1
    $this.val('')
    result = false
    $('<span />',
      'class': "image help-block").text('Chỉ hỗ trợ các loại: ' + fileExtension.join(', ')).appendTo($this.parent())
  else if size > 2097152
    $this.val('')
    result = false
    $('<span />',
      'class': "image help-block").text('Tệp không được lớn hơn: '+ 2097152/1048576 + " MB").appendTo($this.parent())
    return
  return result


ready = ->

  $("form").on 'change', "[type=file]", ->
    if typeof FileReader != 'undefined'
      image_preview = $(this).closest('fieldset').find('#previewImage')
      console.log(image_preview)
      image_preview.empty()
      reader = new FileReader
      if validateUploadedFileType($(this))
        reader.onload = (e) ->
          $('<img />',
            'src': e.target.result
            'class': 'thumb-image').appendTo image_preview
          return
        image_preview.show()
        reader.readAsDataURL $(this)[0].files[0]
      return
    else
      alert 'This browser does not support FileReader.'
    return

  # $("a.fancybox").fancybox()
  #   openEffect	: 'none'
	# 	closeEffect	: 'none'
  #   # closeBtn: false
  #   # helpers:
  #   #   title: type: 'inside'
  #   #   buttons: {}
  #   # return
  return

$(document).ready(ready)
$(document).on('page:load', ready)
