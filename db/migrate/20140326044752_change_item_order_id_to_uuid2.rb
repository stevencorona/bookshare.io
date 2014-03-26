class ChangeItemOrderIdToUuid2 < ActiveRecord::Migration
  def change
    remove_column :items, :order_id
    add_column :items, :order_id, :uuid
  end
end
