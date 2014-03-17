class ChangeBooksStateToStatus < ActiveRecord::Migration
  def change
    rename_column :books, :state, :status
  end
end
