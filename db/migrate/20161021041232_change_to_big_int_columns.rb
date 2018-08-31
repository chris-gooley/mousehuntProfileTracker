class ChangeToBigIntColumns < ActiveRecord::Migration[5.0]
  def up
    change_column :profile_records, :gold, :bigint
    change_column :profile_records, :points, :bigint
    change_column :profile_records, :mice_caught, :bigint
  end

  def down
    change_column :profile_records, :gold, :integer
    change_column :profile_records, :points, :integer
    change_column :profile_records, :mice_caught, :integer
  end
end
