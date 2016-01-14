class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.string :title
      t.string :description
      t.string :lat
      t.string :long
      
      t.timestampsd
      
      t.references :user
    end
  end
end
