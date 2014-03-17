class Payment
  def initialize(order)
    @order = order
  end

  def charge
    Stripe::Charge.create(
      amount: @order.total_amount,
      card: @order.token,
      description: @order.id,
      currency: "usd",
    )
  end
end
