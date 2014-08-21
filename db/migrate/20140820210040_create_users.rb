class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      # DO NOT add unique attribute here; do it in the index!
      t.timestamps
    end
    
    add_index :users, :email
  end
end
