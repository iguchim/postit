class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :voteable_id, uniqueness: { scope: [:user_id, :voteable_type] }
end