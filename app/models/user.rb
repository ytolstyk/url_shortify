class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  
  has_many(
    :submitted_urls,
    class_name: "ShortenedUrl",
    foreign_key: :submitter_id,
    primary_key: :id
  )
  
  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :visitor_id,
    primary_key: :id
  )
  
  has_many(
    :visited_urls,
    Proc.new { distinct },
    through: :visits, #points to has_many association above
    source: :visited_urls #points to belongs_to in visits
  )
end