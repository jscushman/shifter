class AddUserToPerson < ActiveRecord::Migration
  def change
    add_reference :people, :user, index: true, foreign_key: true
  end
end
