class CreateOrders < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :orders, id: :uuid do |t|

      t.string :name
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :token

      t.integer :total_amount
      t.integer :donation_amount

      t.string :state

      t.timestamps
    end
  end
end
