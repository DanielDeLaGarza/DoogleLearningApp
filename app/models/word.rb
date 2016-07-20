class Word < ApplicationRecord
  has_many :definitions, dependent: :destroy
  before_save {content.downcase!}
  validates :content, presence: true, allow_blank: false, format: { with: /\A[A-Za-z-]*\z/ }, uniqueness:  {case_sensitive: false}
end
