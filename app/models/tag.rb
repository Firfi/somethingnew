# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base

  attr_accessible :name
  has_many :taggings
  has_many :notes, through: :taggings

  validates_presence_of :name
  validates_uniqueness_of :name

  def name=(t)
    super self.class.sanitize_name(t)
  end

  def self.tags_for(user, prefix)
    logger.warn(prefix)
    Rails.cache.fetch(["tags", user.id, prefix]) do
      tgs = user.tags.where(arel_table[:name].matches("#{prefix}%")).uniq.pluck(:name)
      logger.warn tgs
      tgs
    end
  end

  def self.sanitize_name(n)
    (n || '').gsub(/[^0-9a-z]/i, '')
  end

end
