class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.integer :restaurant_id, null: :false
      t.string :title, null: :false
      t.string :menu_image_id
      t.text :content, null: :false
      t.text :cancel, null: :false
      t.integer :regular_price, null: :false
      t.integer :discount_price, null: :false
      t.integer :reservation_method, null: :false, default: 0
      t.boolean :is_sale_frag, null: :false, default: true

      t.timestamps
    end
  end
end
