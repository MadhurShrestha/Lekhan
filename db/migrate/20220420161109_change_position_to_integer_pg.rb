class ChangePositionToIntegerPg < ActiveRecord::Migration[6.1]
  def change
    change_column :pages, :position, 'integer USING CAST("position" AS integer)'

  end
end
