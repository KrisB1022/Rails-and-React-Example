class CreateSitters < ActiveRecord::Migration[5.2]
  def change
    create_table :sitters do |t|
      t.string :name
      t.string :image
      t.string :phone_number
      t.string :email
      t.integer :stays, default: 0,
      t.integer :sitter_score
      t.integer :ratings_score
      t.integer :overall_score

      t.timestamps
    end
  end
end
