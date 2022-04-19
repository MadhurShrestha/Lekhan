class Notebook < ApplicationRecord
  belongs_to :user
  has_many :pages, dependent: :destroy

 include MeiliSearch::Rails
   extend Pagy::Meilisearch


    meilisearch do
      attribute :title
      attribute :pages do
        pages.pluck('title')
      end
    end

  def get_next_page_position
    if pages.none? { |page| page.persisted?}
      1
    else
      pages.order(position: :asc).last.position + 1
    end
  end
end
