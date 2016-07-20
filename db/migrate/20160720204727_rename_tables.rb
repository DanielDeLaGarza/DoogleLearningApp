class RenameTables < ActiveRecord::Migration[5.0]
  def change
    rename_column(:word_definitions, :definition, :content)
    rename_table(:word_definitions, :definitions)

    rename_column(:words, :word, :content)
  end
end
