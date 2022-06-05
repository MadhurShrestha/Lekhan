class AddStrippedContentToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :stripped_content, :string
  end
end
