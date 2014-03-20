class OrderMailer < ActionMailer::Base
  default from: "Steve at Bookshare <steve@mg.bookshare.io>"

  def thank_you_email(order)
    @order = order

    mail(to: @order.email, subject: "Your free books are on the way!")
  end

end
