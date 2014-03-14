class AddNotesAuthorPagesDateDescriptionToBooks < ActiveRecord::Migration
  def change
    add_column :books, :notes, :text, after: :isbn
    add_column :books, :description, :text, after: :notes
    add_column :books, :author, :string, after: :title
    add_column :books, :pages, :integer, after: :author
    add_column :books, :published_at, :timestamp
  end
end
