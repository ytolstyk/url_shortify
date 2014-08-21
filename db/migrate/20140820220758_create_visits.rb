class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visitor_id
      t.string  :shortened_url
      
      t.timestamps
    end
  end
end
