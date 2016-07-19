class CreateWordDefinitions < ActiveRecord::Migration[5.0]
  def change
    create_table :word_definitions do |t|
      t.text :definition
      t.references :word, foreign_key: true

      t.timestamps
    end
  end
end
