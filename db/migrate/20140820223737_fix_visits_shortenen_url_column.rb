class FixVisitsShortenenUrlColumn < ActiveRecord::Migration
  def change
    remove_column :visits, :shortened_url
    
    add_column :visits, :shortened_url_id, :integer
    
    add_index :visits, :shortened_url_id
  end
end
