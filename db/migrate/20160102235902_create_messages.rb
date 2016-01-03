class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :recipient_id
      t.string :body
      t.boolean :viewed

      t.timestamps null: false
    end
  end
end
