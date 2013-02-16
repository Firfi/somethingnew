# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Note < ActiveRecord::Base
  attr_accessible :content, :user_id, :tag_list

  belongs_to :user

  has_many :taggings
  has_many :tags, through: :taggings

  validates_presence_of :tag_list, :content

  def self.tagged_with(name)
    Tag.find_by_name!(name).notes
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
        joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = self.class.filter_tags names
  end

  def as_json(options = {})
    super(options.merge(:methods => [:tag_list]))
  end

  def self.filter_tags(tag_string)
    tag_string.split(",").map { |n| Tag.sanitize_name(n) }.inject([]) { |a, n| a << n unless n.blank?; a }.map do |n|
      Tag.where(name: n).first_or_create!
    end
  end

end
