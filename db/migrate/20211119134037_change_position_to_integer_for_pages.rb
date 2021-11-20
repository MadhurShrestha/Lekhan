class ChangePositionToIntegerForPages < ActiveRecord::Migration[6.1]
  def change
    change_column :pages, :position, :integer
  end
end
