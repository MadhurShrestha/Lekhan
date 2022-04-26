class Page < ApplicationRecord
  belongs_to :notebook
  has_rich_text :content

  has_many :image_elements, dependent: :destroy
  has_many :checklists, dependent: :destroy

 # include MeiliSearch::Rails

 #    meilisearch do
 #      attribute :title
 #      attribute :content
 #    end


end
