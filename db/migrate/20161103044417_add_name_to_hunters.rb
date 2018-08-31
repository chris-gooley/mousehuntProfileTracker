class AddNameToHunters < ActiveRecord::Migration[5.0]
  def change
    add_column :hunters, :name, :string
    add_column :hunters, :team, :string
  end
end
