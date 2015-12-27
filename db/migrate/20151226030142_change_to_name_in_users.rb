class ChangeToNameInUsers < ActiveRecord::Migration
  def change
    remove_column :users, :fname, :string
    remove_column :users, :lname, :string
    add_column :users, :name, :string
  end
end
