class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :name
      t.float :preparation_time
      t.float :cooking_time
      t.text :description
      t.boolean :public, :default => false

      t.timestamps
    end
  end
end
