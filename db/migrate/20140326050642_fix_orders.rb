class FixOrders < ActiveRecord::Migration
  def change
    drop_table :orders
    create_table :orders do |t|

      t.string :name
      t.string :uuid
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :token
      t.string :status

      t.integer :total_amount
      t.integer :donation_amount

      t.string :state

      t.timestamps
    end

    add_index :orders, :email


    remove_column :items, :order_id, :uuid
    add_column :items, :order_id, :integer
  end
end
