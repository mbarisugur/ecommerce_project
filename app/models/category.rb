class Category < ApplicationRecord

  after_save :after_saved_method
  before_save :before_saved_method
  has_many :products

  validates :name, presence: true, length: {minimum:2, maximum:20}

  def after_saved_method
    p 'after saved calisti.'
  end

  def before_saved_method
    p 'before save'
  end

end
