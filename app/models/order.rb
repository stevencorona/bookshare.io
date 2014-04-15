class Order < ActiveRecord::Base
  include ActiveModel::Transitions

  has_many :items
  has_many :books, through: :items

  before_save :make_uuid


  def make_uuid
    self.uuid = SecureRandom.hex(16)
  end

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

    event :ship do
      transitions to: :shipped, from: [:paid]
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

  def shipment(weight, box="MediumFlatRateBox")
    EasyPost.api_key = '5YX1ixWcX8hPhNYkeilUkg'
    #EasyPost.api_key = 'rZXXVviGZBmK0iJNFrEAeg'

    to_address = EasyPost::Address.create(
      :name => self.name,
      :street1 => self.address1,
      :street2 => self.address2,
      :city => self.city,
      :state => self.state,
      :zip => self.zip
    )
    from_address = EasyPost::Address.create(
      :company => 'Steve Corona',
      :street1 => '1904 Grandview Ct',
      :city => 'Mt Pleasant',
      :state => 'SC',
      :zip => '29464',
    )

    parcel = EasyPost::Parcel.create(
      :predefined_package => box,
      :weight => weight
    )

    shipment = EasyPost::Shipment.create(
      :to_address => to_address,
      :from_address => from_address,
      :parcel => parcel,
    )

    shipment

  end

end
