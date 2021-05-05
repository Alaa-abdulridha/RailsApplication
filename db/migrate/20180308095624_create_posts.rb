class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :name 
      t.string :description
      t.date :date
      t.string :address
      t.string :city
      t.integer :zipcode
      t.string :state
      t.string :country
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
