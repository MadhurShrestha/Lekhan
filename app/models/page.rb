class Page < ApplicationRecord
  include PgSearch::Model

  before_save :strip_content_and_save

  pg_search_scope :search, against: [:title, :stripped_content],
    associated_against: {
      notebook: :title
    },
    using: {
      tsearch: {
        prefix: true,
        dictionary: "english",
        any_word: true
      }
    }

  belongs_to :notebook

  has_paper_trail

  has_many :image_elements, dependent: :destroy
  has_many :checklists, dependent: :destroy

  def strip_content_and_save
    self.stripped_content = ActionController::Base.helpers.strip_tags(content)
  end
end
