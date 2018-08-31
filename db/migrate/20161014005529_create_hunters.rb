class CreateHunters < ActiveRecord::Migration[5.0]
  def change
    create_table :hunters do |t|
      t.string :profile_id
      t.string :email
      t.string :password_digest
      t.datetime :started_hunting
      t.datetime :last_scanned

      t.timestamps
    end
  end
end
