class Product < ApplicationRecord

  has_one_attached :product_image
  #has_many :category
  belongs_to :category

  validates :name, presence: true, length: {minimum:2, maximum:20}
  validates :description, presence: true, length: {minimum:5, maximum:250}
  validates :quantity, presence: true, numericality: {greater_than: 0, less_than: 100}
  validates :price, presence: true, numericality: {greater_than: 0}

  after_save :delete_product_after_30days

  def delete_product_after_30days
    #ProductJob.set(wait: 1.minutes).perform_later(self)
  end
  #validate :name_start_with_a

  def name_start_with_a
    unless self.name.start_with?('A')
      errors.add(:name, "A harfi ile baslamali")
    end
  end

end
