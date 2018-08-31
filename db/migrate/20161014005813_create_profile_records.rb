class CreateProfileRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :profile_records do |t|
      t.string :title
      t.integer :title_progress
      t.integer :points
      t.integer :gold
      t.integer :horn_calls
      t.integer :breeds_caught
      t.integer :breeds_total
      t.integer :event_breeds_caught
      t.integer :event_breeds_total
      t.integer :mice_caught
      t.string  :location
      t.string  :region
      t.string  :trap
      t.string  :base
      t.string  :charm
      t.string  :bait_name
      t.integer :bait_amount
      t.integer :trap_power
      t.integer :trap_luck
      t.string  :team
      t.belongs_to :hunter, foreign_key: true

      t.timestamps
    end
  end
end
