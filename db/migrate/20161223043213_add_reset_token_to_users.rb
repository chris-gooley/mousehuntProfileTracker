class AddResetTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :hunters, :reset_token, :string
  end
end
