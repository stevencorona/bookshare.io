class Order < ActiveRecord::Base
  include ActiveModel::Transitions

  has_many :items
  has_many :books, through: :items

  state_machine attribute_name: :status do
    state :pending_info
    state :pending_payment
    state :paid
    state :shipped

    event :shipment_manifest do
      transitions to: :pending_payment, from: [:pending_info, :pending_payment]
    end

    event :paid do
      transitions to: :paid, from: [:pending_payment]
    end
  end

  def reserve_books
    self.books.each do |book|
      book.reserve!
    end
  end

  def unreserve_books
    self.books.each do |book|
      book.unreserve!
    end
  end

end
