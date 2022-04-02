class Paragraph < ApplicationRecord
  belongs_to :page
  has_rich_text :content


 # include MeiliSearch::Rails

 #    meilisearch do
 #      attribute :content
 #    end
end
