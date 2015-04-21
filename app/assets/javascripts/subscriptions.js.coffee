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
    @urlTemplate = $select.attr('dataurl')
    @targetSelect = $($select.attr('datatarget'))
    $select.on 'change', =>
      @clearTarget()
      url = @constructUrl($select.val())
      if url
        $.getJSON url, (data) =>
          $.each data, (index, el) =>
            @targetSelect.append "<option value='" + el.id + "'>" + el.value + "</option>"
            # reinitialize target select
          @reinitializeTarget()
      else
        @reinitializeTarget()

  reinitializeTarget: ->
    @targetSelect.trigger("change")

  clearTarget: ->
    @targetSelect.html('<option></option>')

  constructUrl: (id) ->
    if id && id != ''
      @urlTemplate.replace(/:.*_id/, id)


$ ->
  $('#subscription_course_class_id').priceSelectable()