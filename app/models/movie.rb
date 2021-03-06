class Movie < ApplicationRecord

  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  validate :image_size_validation

  mount_uploader :image, ImageUploader, :mount_on => :image

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size >= 1
  end

  scope :duration_search_1, -> { where("runtime_in_minutes < ?", 90) }
  scope :duration_search_2, -> { where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?", 90, 120) }
  scope :duration_search_3, -> { where("runtime_in_minutes > ?", 120) }

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

  def image_size_validation
    errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
  end

end
