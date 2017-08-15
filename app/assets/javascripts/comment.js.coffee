flexComment = ($el) ->
  $this = $el
  $expand = $this.find('.expand').filter(':first')
  $collapsables = $this.find(".sub-comments")
  $expand.on 'click', (e) ->
    toggle($expand, $collapsables)
    return
  return

toggle = ($exp, $col) ->
  $col.slideToggle(200)
  if $exp.text() == "[-] " then $exp.text('[+] ') else $exp.text('[-] ')
  return

addComment = ($el) ->
  $this = $el
  $edit = $this.closest(".action").find(".edit")
  $delete = $this.closest(".action").find(".delete")
  $data = $this.data('fields')

  $this.before($data)
  $this.hide()
  $edit.hide()
  $delete.hide()
  event.preventDefault()
  return

cancelComment = ($el) ->
  $this = $el
  $addComment = $this.closest('.reply').find('.add_comment')
  $commentForm = $this.closest('.reply').find('form')
  $edit = $this.closest(".action").find(".edit")
  $delete = $this.closest(".action").find(".delete")

  $addComment.show()
  $commentForm.remove()
  $edit.show()
  $delete.show()
  event.preventDefault()
  return

deleteCommentQuestion = ($el) ->
  $el.next().show()
  $el.hide()
  return

deleteCommentCancel = ($el) ->
  $el.closest(".confirmation").hide();
  $el.closest(".delete").find(".intent").show();
  return


ready = ->

  $(".action").on 'click', '.add_comment', (event) ->
    addComment($(this))
    return

  $('.action').on 'click', '.cancel', (event) ->
    cancelComment($(this))
    return

  $li = $('li')
  $li.each (i) ->
    flexComment($(this))
    return

  $(document).ajaxStart ->
    $('.fa-spinner').show()
    return

  $(document).ajaxStop ->
    $('.fa-spinner').hide()
    return

  $('.delete').on 'click', '.intent', (event) ->
    event.preventDefault();
    deleteCommentQuestion($(this))
    return

  $('.delete').on 'click', '.cancel', (event) ->
    event.preventDefault();
    deleteCommentCancel($(this))
    return

  return
$(document).ready(ready)
$(document).on('page:load', ready)
