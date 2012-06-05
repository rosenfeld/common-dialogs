CD = @CommonDialogs =
  defaults: m =
    title:
      message: 'Message'
      error: 'Error'
      confirm: 'Please, confirm'
      input: 'Please, answer'
    messages:
      ok: 'Ok'
    confirm:
      yes: 'Yes'
      no: 'No'
    input:
      ok: 'Ok'
      cancel: 'Cancel'
      cantBeEmpty: "input field can't be empty"

  require: -> window[f] = CD[f] for f in ['showMessage', 'showError', 'confirmDialog', 'inputDialog']

  showMessage: (message, options={})->
    content = $('<div class=alert-dialog />').text(message)
    content.addClass(c) if c = options.additionalClasses
    buttons = createButtons [[m.messages.ok, -> $(this).dialog 'close']]
    createDialog content, options.title or m.title.message, buttons, options.onClose

  showError: (message, options={})=>
    options.title ?= m.title.error
    options.additionalClasses = 'error'
    CD.showMessage message, options

  confirmDialog: (question, onConfirm, options={})->
    content = $('<div class=confirm-dialog />').text(question)
    buttons = createButtons [
      [m.confirm.yes, -> onConfirm(); $(this).dialog 'close']
      [m.confirm.no, -> options.noAction?(); $(this).dialog 'close']
    ]
    createDialog content, options.title or m.title.confirm, buttons, options.onClose

  inputDialog: (message, onConfirm, options={})->
    options.required ?= true
    content = $('<div class=input-dialog />')
      .append($('<div class=message/>').text message)
      .append(input = $('<input type=text />'))
    input.val options.initialValue
    input.keydown (ev)->
      return unless ev.which is 13 # ENTER
      dialog.siblings('.ui-dialog-buttonpane').find('button:eq(0)').click()

    canceled = true
    buttons = createButtons [
      [m.input.ok, ->
        value = input.val().trim()
        unless value or not options.required
          CD.showError m.input.cantBeEmpty, onClose: -> input.focus()
          return
        onConfirm value
        $(this).dialog 'close'
        canceled = false
      ]
      [m.input.cancel, -> $(this).dialog 'close']
    ]
    dialog = createDialog content, options.title or m.title.input, buttons,
      -> options.cancelAction?() if canceled
    input.select().focus()

createButtons = (buttons) ->
  hash = {}
  hash[button[0]] = button[1] for button in buttons
  hash

createDialog = (content, title, buttons, onClose)->
  $('<div/>').append(content).dialog
    minHeight: 50
    modal: true
    close: -> $(this).dialog('destroy').remove(); onClose?()
    title: title
    buttons: buttons
