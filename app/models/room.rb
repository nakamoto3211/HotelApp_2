class Room < ApplicationRecord 
  validates :name, presence: true
  validates :detail, presence: true
  validates :charge, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :address, presence: true

  mount_uploader :hotel_image, ImageUploader

  belongs_to :user
  has_many :reservations

  def self.search(area, keyword)
    if area.present? and keyword.present?
      Room.where(['address LIKE(?) AND ( name LIKE(?) OR detail LIKE(?) )',"%#{area}%", "%#{keyword}%", "%#{keyword}%"])
    elsif area.present? and keyword.blank?
      Room.where(['address LIKE(?)', "%#{area}%"])
    elsif area.blank? and keyword.present?
      Room.where(['name LIKE(?) OR detail LIKE(?)', "%#{keyword}%", "%#{keyword}%"])
    else
      Room.all
    end
  end

end
