class ChangeColumnsInItems < ActiveRecord::Migration[6.0]
  def change
    change_column_null :items, :title, false
    change_column_null :items, :desc, false
  end
end
