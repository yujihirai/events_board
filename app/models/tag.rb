class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name

  has_many :taggings, dependent: :destroy
  has_many :events, through: :taggings

  def to_s
    name
  end
end
