class ChangeItemOrderIdToUuid < ActiveRecord::Migration
  def change
    change_column :items, :order_id, :string
  end
end
