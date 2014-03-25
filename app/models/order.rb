class Order < ActiveRecord::Base
  include ActiveModel::Transitions

  has_many :items
  has_many :books, through: :items

  validates_uniqueness_of :email, case_sensitive: false, allow_nil: true
  validates_presence_of :name,     allow_nil: true
  validates_presence_of :address1, allow_nil: true
  validates_presence_of :city,     allow_nil: true
  validates_presence_of :state,    allow_nil: true
  validates_presence_of :zip,      allow_nil: true
  validates_presence_of :country,  allow_nil: true

  state_machine attribute_name: :status do
    state :pending_info
    state :pending_payment
    state :paid
    state :shipped
    state :duplicate

    event :shipment_manifest do
      transitions to: :pending_payment, from: [:pending_info, :pending_payment]
    end

    event :paid do
      transitions to: :paid, from: [:pending_payment]
    end

    event :duplicate do
      transitions to: :duplicate, from: [:pending_info, :pending_payment]
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
