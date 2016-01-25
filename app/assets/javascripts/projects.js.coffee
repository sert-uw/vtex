$ ->
  $('#file_text_area')
    .on 'keyup', (e) ->
      if e.keyCode < 37 || 40 < e.keyCode
        $('#update_button').trigger('click')

    .autosize()

  $("a[data-remote]")
    .on 'ajax:complete', (event, ajax, status) ->
      response = $.parseJSON(ajax.responseText)

      method = response.data.method
      file = response.data.file

      $(this).closest('#' + file).remove()

  $('#update')
    .on 'ajax:complete', (event, ajax, status) ->
      response = $.parseJSON(ajax.responseText)
      file = response.data.file

  $('#pdf_update')
    .on 'ajax:complete', (event, ajax, status) ->
      response = $.parseJSON(ajax.responseText)
      status = response.status
      path = response.data.path

      if status == 'success'
        if !$('#pdf_file_link').is(':visible')
          $('#pdf_file_link').toggle()
        if $('#err_file_link').is(':visible')
          $('#err_file_link').toggle()
      else
        if $('#pdf_file_link').is(':visible')
          $('#pdf_file_link').toggle()
        if !$('#err_file_link').is(':visible')
          $('#err_file_link').toggle()

      window.open(path)

  $('#pdf_update_under')
    .on 'click', () ->
      $('#pdf_update').trigger('click')

  $('#create')
    .on 'ajax:complete', (event, ajax, status) ->
      response = $.parseJSON(ajax.responseText)

      if response.status == 'error'
        alert response.data.message
        return

      html = response.data.html
      tag_id = response.data.tag_id

      if tag_id.indexOf('_tex') >= 0
        $('#tex_tbody').append html
      else
        $('#image_tbody').append html

      $('#' + tag_id)
        .on 'ajax:complete', (event, ajax, status) ->
          response = $.parseJSON(ajax.responseText)

          method = response.data.method
          file = response.data.file

          $(this).closest('#' + file).remove()
