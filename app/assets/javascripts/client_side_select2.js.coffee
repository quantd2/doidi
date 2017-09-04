# ready = ->

  # Add select2 support
  ClientSideValidations.selectors.validate_inputs += ', select[data-select2-validate]'
  ClientSideValidations.selectors.inputs += ', .select2-container'
  getSelect2 = (element) ->
    $(element).parent().find('select')
    
  $.fn.base = window.ClientSideValidations.enablers.input

  window.ClientSideValidations.enablers.input = (element) ->
    extend = ->
      unless $(element).hasClass 'select2-container'
        $.fn.base(element)
      else
        $placeholder = $(element)
        $select = $placeholder.parent().find('select')
        form   = $select[0].form
        $form  = $(form)
        if $select.attr('data-select2-validate')
          # only focus event should be handled by placeholder
          $placeholder.on(event, binding) for event, binding of {
            'focusout.ClientSideValidations': ->
              getSelect2(@).isValid(form.ClientSideValidations.settings.validators)
          }
          $select.on(event, binding) for event, binding of {
            'change.ClientSideValidations':   -> getSelect2(@).data('changed', true)
            # Callbacks
            'element:validate:after.ClientSideValidations':  (eventData) -> ClientSideValidations.callbacks.element.after(getSelect2(@),  eventData)
            'element:validate:before.ClientSideValidations': (eventData) -> ClientSideValidations.callbacks.element.before(getSelect2(@), eventData)
            'element:validate:fail.ClientSideValidations':   (eventData, message) ->
              element = $(@)
              ClientSideValidations.callbacks.element.fail(element, message, ->
                form.ClientSideValidations.addError(element, message)
              , eventData)
            'element:validate:pass.ClientSideValidations':   (eventData) ->
              element = $(@)
              ClientSideValidations.callbacks.element.pass(element, ->
                form.ClientSideValidations.removeError(element)
              , eventData)
          }
    extend()

#   return
# $(document).ready(ready)
# $(document).on('page:load', ready)
