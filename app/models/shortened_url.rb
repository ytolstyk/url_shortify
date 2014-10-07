require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )
  
  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )
  
  has_many(
    :url_visitors,
    Proc.new { distinct },
    through: :visits, #from has_many association above 
    source: :visitors #from belongs_to in visits
  )
  
  def self.random_code
    unique = false
    
    until unique
      code = SecureRandom.base64
      unique = !ShortenedUrl.exists?(['short_url = ?', code])
    end
    
    code
  end
  
  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
    long_url: long_url,
    short_url: ShortenedUrl.random_code,
    submitter_id: user.id,
    )
  end
  
  def num_clicks
    self.visits.select(:visitor_id).count
  end
  
  def num_uniques
    self.url_visitors.select(:visitor_id).count
  end
  
  def num_recent_uniques
    self.url_visitors.select(:visitor_id).where("created_at > ?", 10.minutes.ago).count
  end
end
