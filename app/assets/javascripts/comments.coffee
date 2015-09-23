source = new EventSource('/comments')

source.onmessage = (event) ->
  $('#comments').find('.media-list').prepend($.parseHTML(event.data))
  $('.media-body').emoticonize()


jQuery ->
  $('#new_comment').submit ->
    $(this).find("input[type='submit']").val('Sending...').prop('disabled', true)

  return
