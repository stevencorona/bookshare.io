class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :order
      t.references :book
      t.timestamps
    end
  end
end
