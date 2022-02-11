class Page < ApplicationRecord
  belongs_to :notebook
  has_many :paragraphs, dependent: :destroy
  has_many :image_elements, dependent: :destroy
  has_many :checklists, dependent: :destroy

  def elements
    paragraphs + image_elements + checklists
  end
end
