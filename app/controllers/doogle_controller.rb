class DoogleController < ApplicationController
  def home
  end

  def search
    input = params[:word_entry][:word]
    @word = Word.find_by(content: input)

    if(@word != nil)
      @definitions = @word.formated_definitions
      @validation_text = ""

    else
      @word = Word.new()
      @word.content = params[:word_entry][:word]

      if @word.valid?
        @definitions = get_word_definitions_from_api(@word.content)

        if @definitions != nil && @definitions.length > 0
          @word.save_with_definitions(@definitions)
          @validation_text = @word.get_validation_text

        else
          @validation_text = "The word #{@word.content} was not found in our dictionary. are you sure you spelled it right?"
        end
      else
        @validation_text = @word.get_validation_text
        @definitions = []
      end
    end

    respond_to do |format|
      format.js
    end
  end

  #_PRIVATE__METHODS____________________________________________________________________
  private
    def get_word_definitions_from_api(word)
      conn = Faraday.new(:url => 'http://www.dictionaryapi.com/api/v1/references/collegiate/xml') do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
      response = conn.get word, { :key => 'cab72891-f003-43ef-a983-253666d45082' }

      doc  = Nokogiri::XML(response.body)
      doc.xpath("//dt").map {|d| d.text.gsub!(':', '')}
    end
end