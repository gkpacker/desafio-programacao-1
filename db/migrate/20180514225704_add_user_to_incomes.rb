class AddUserToIncomes < ActiveRecord::Migration[5.2]
  def change
    add_reference :incomes, :user, foreign_key: true
  end
end
