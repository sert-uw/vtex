$ ->
  $('#file_edit_area')
    .on 'keyup', (e) ->
      if e.keyCode < 37 || 40 < e.keyCode
        $.ajax({
          type: 'PUT',
          url: '/projects/' + project_id + '/files.json',
          data: {
            'content': $('#file_edit_area').html(),
            'file': $('#file_name_label').text()
          }
        })

      if e.keyCode == 104
        selection = window.getSelection()
        orgRange = selection.getRangeAt(0)

        changeColor(this)

        selection.removeAllRanges()
        selection.addRange(orgRange)

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

$(document)
  .on 'ready page:load', () ->
    changeColor(document.getElementById('file_edit_area'))
    changeColor(document.getElementById('file_edit_area'))
    changeColor(document.getElementById('file_edit_area'))

changeColor = (obj) ->
  selection = window.getSelection()

  regexps = [/%.*$/g, /\\\w*/g, /\{[\w\.\/:一-龠ぁ-ン]+\}|\{|\}/g, /\[[\w,=\.]+\]/g]
  colors = ['steelblue', 'gold', 'magenta', 'tomato']

  for regexp, i in regexps
    nodes = obj.childNodes
    for item, itemCnt in nodes
      if item.nodeName != '#text'
        continue

      results = item.data.match(regexp)
      if results != null
        ranges = []
        for val in results
          sPos = item.data.indexOf(val)
          ePos = sPos + val.length

          range = document.createRange()
          range.setStart(item, sPos)
          range.setEnd(item, ePos)
          ranges.push(range)

        for range in ranges
          selection.removeAllRanges()
          selection.addRange(range)
          document.execCommand('ForeColor', false, colors[i])
