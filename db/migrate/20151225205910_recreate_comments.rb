class RecreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :body
      t.integer :commentable_id
      t.string :commentable_type
   
      t.timestamps
    end
     
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
