class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :title
      t.text :description
      t.integer :max_simultaneous

      t.timestamps null: false
    end
  end
end
