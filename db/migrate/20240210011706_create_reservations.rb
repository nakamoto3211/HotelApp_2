class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :number_of_people
      t.date :check_in
      t.date :check_out
      t.integer :user_id

      t.timestamps
    end
  end
end
