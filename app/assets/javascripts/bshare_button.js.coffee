# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

update_response = (xhr, data, status) ->
  $("#response").html(data)

jQuery ->
  $("#user_suggestion_div").bind("ajax:success", update_response(xhr, data, status))
      