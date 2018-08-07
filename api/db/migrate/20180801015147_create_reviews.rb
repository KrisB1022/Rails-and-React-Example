class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.date :end_date
      t.string :text
      t.date :start_date
      t.belongs_to :sitter, foreign_key: true

      t.timestamps
    end
  end
end
