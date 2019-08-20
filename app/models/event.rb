class Event < ApplicationRecord
  attr_accessor :tag_list
  searchkick
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :organizer, class_name: "User", foreign_key: "user_id"
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances
  has_many :likes, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, length: { minimum: 5 }
  validates :venue, presence: true
  validates :location, presence: true

  mount_uploader :image, ImageUploader

  def tag_list
    tags.join(", ")
  end

  def tag_list=(names)
    tag_names = names.split(",").collect {|str| str.strip.downcase}.uniq
    new_or_existing_tags = tag_names.collect {|tag_name| Tag.find_or_create_by(name: tag_name)}
    self.tags = new_or_existing_tags
  end

  def seats_left
    seats - attendees.count
  end

  def seats_left?
    seats == attendees.count
  end

  def likes_total
    self.likes.where(like: "like").count
  end

  def dislikes_total
    self.likes.where(like: "dislike").count
  end
end
