class Word < ApplicationRecord
  has_many :definitions, dependent: :destroy
  before_save {content.downcase!}
  validates :content, presence: true, allow_blank: false, format: { with: /\A[A-Za-z-]*\z/ }, uniqueness:  {case_sensitive: false}

  def save_with_definitions(definitions)
    self.save
    definitions.each do |definition|
      self.definitions.create(content: definition)
    end
  end

  def formated_definitions
    self.definitions.map {|d| d.content}
  end

  def get_validation_text
    if !self.valid?
      word = self.content
      validation_text = ""
      if word == nil || word == ""
        validation_text = "Please type a word to search."
      else
        if word =~ /\d/
          validation_text = "Words may not include digits!"
        end
        if word =~ /\s/
          validation_text = "#{validation_text} Words may not include spaces!"
        end
        validation_text = "#{validation_text} Please only use letters and hyphens."
      end
      validation_text
    else
      ""
    end
  end
end
