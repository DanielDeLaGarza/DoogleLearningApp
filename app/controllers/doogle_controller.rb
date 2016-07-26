class DoogleController < ApplicationController
  def home
  end

  def search
    input = params[:word_entry][:word]
    @word = Word.find_by(content: input)

    #if word is already in database
    if(@word != nil)

      @definitions = format_definitions(@word.definitions)
      @validation_text = ""
      #byebug

    #if word is not already in database
    else
      @word = Word.new()
      @word.content = params[:word_entry][:word]

      if(@word.valid?)
        @definitions = get_word_definitions_from_api(@word.content)
        if (@definitions != nil && @definitions.length > 0 )
          #@word.save
          #save_definitions(@word, @definitions)

        else
          @validation_text = "The word #{@word.content} was not found in our dictionary. are you sure you spelled it right?"
        end

      #ivalid word handling
      else
        @validation_text = get_validation_text(@word.content)
        @definitions = []
      end
    end

    respond_to do |format|
      format.js
    end
  end

  #_PRIVATE__METHODS____________________________________________________________________
  private
    def get_validation_text(word)
      if(word == nil || word == "")
        @validation_text = "Please type a word to search."
      else
        if(word =~ /\d/)
          @validation_text = "Words may not include digits!"
        end
        if(word =~ /\s/)
          @validation_text = "#{@validation_text} Words may not include spaces!"
        end
        @validation_text = "#{@validation_text} Please only use letters and hyphens."
      end
      return @validation_text
    end

    def get_word_definitions_from_api(word)
      return []
    end

    def format_definitions(definitions)
      arr = []
      definitions.each do |definition|
        arr.push(definition.content)
      end
      return arr
    end

    def save_definitions(word, definitions)

    end
end