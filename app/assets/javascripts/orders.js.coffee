# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("input#donation").click ->

    if $(this).is(":checked")
      $("#donation_amount").html("$3.00")
      total = ($("#total_amount").data("amount") + 300)
      $("#total_amount b").html("$" + (total / 100.0).toFixed(2))
      $("#total_charge").html("$" + (total / 100.0).toFixed(2))
      $("#total_amount").data("amount", total)

    else
      $("#donation_amount").html("$0.00")
      total = ($("#total_amount").data("amount") - 300)
      $("#total_amount b").html("$" + (total / 100.0).toFixed(2))
      $("#total_charge").html("$" + (total / 100.0).toFixed(2))
      $("#total_amount").data("amount", total)

  handler = StripeCheckout.configure {
    key: $('meta[name="stripe-key"]').attr('content'),
    token: (token, args) ->
      $("#token").val(token.id)
      $("#email").val(token.email)
      $("form#payment").submit()
  }

  $("#checkout").click ->
    handler.open {
      name: "bookshare.io",
      description: "Shipping & Handling for Books",
      amount: $("#total_amount").data("amount")
    }
