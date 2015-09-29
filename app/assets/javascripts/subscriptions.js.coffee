# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.fn.extend
  priceSelectable: ->
    $(@).each (i, el) ->
      new PriceSelectable($(el))

class PriceSelectable
  constructor: ($select) ->
    @init($select)

  init: ($select) ->
    console.log $select
    console.log $select.attr('dataUrl')
    console.log $select.attr('dataTarget')
    @urlTemplate = $select.attr('dataUrl')
    @targetSelect = $($select.attr('dataTarget'))
    $select.on 'change', =>
      @clearTarget()
      url = @constructUrl($select.val())
      if url
        $.getJSON url, (data) =>
          $.each data, (index, el) =>
            desc = if (el.payment_quantity == 1) then " parcela" else " parcelas"
            @targetSelect.append "<option value='" + el.id + "'>" + el.description + " - " + el.payment_quantity + desc + " de R$ " + el.payment_value + "</option>"
            # reinitialize target select
          @reinitializeTarget()
      else
        @reinitializeTarget()

  reinitializeTarget: ->
    @targetSelect.trigger("change")

  clearTarget: ->
    @targetSelect.html('<option></option>')

  constructUrl: (id) ->
    console.log @urlTemplate
    if id && id != ''
      @urlTemplate.replace(/:.*_id/, id)


$ ->
  $('#subscription_course_class_id').priceSelectable()
