class CreatePosts < ActiveRecord::Migration
  def change
    enable_extension :hstore

    create_table :posts do |t|
      t.hstore :title
      t.json :content
      t.jsonb :price

      t.timestamps null: false
    end
  end
end
