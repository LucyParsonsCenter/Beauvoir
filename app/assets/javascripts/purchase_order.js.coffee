jQuery ->
  $('.best_in_place').best_in_place()
  $("a#add_purchase_order_line_item").on "click", (e, data, status, xhr) ->
    $("#new_purchase_order_line_item").trigger("submit.rails")


#  $("a#new_purchase_order_line_item").on "ajax:success", (e, data, status, xhr) ->
#   $("#purchase_order_line_items").append(xhr.responseText)
