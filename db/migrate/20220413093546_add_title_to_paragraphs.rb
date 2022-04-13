class AddTitleToParagraphs < ActiveRecord::Migration[6.1]
  def change
    add_column :paragraphs, :title, :string
  end
end
