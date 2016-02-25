class AddUserToBug < ActiveRecord::Migration
  def change
    add_reference :bugs, :user, index: true, foreign_key: true
  end
end
