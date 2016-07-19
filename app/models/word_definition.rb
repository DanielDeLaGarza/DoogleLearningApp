class WordDefinition < ApplicationRecord
  belongs_to :word
  validates :word_id, presence: true
  validates :content, presence: true, length: {maximum: 500}
end
