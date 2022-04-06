class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :user_id, null: :false
      t.integer :menu_id, null: :false
      t.integer :reservation_year, null: :false
      t.string :reservation_month, null: :false
      t.string :reservation_day, null: :false
      t.string :reservation_time, null: :false
      t.integer :people, null: :false
      t.integer :reservation_status, null: :false, default: 0

      t.timestamps
    end
  end
end
