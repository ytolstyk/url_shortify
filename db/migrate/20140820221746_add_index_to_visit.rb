class AddIndexToVisit < ActiveRecord::Migration
  def change
    add_index :visits, :shortened_url
    add_index :visits, :visitor_id
  end
end
