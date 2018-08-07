class CreateOwners < ActiveRecord::Migration[5.2]
  def change
    create_table :owners do |t|
      t.string :name
      t.string :image
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
