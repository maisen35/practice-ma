class AddNullFalse < ActiveRecord::Migration[5.2]

  def up
    change_column :contacts, :email, :string, null: false
    change_column :contacts, :message, :text, null: false
    change_column :menus, :restaurant_id, :integer, null: false
    change_column :menus, :title, :string, null: false
    change_column :menus, :regular_price, :integer, null: false
    change_column :menus, :discount_price, :integer, null: false
    change_column :menus, :reservation_method, :integer, null: false
    change_column :reservations, :user_id, :integer, null: false
    change_column :reservations, :menu_id, :integer, null: false
    change_column :reservations, :reservation_year, :integer, null: false
    change_column :reservations, :reservation_month, :string, null: false
    change_column :reservations, :reservation_day, :string, null: false
    change_column :reservations, :reservation_time, :string, null: false
    change_column :reservations, :people, :integer, null: false
    # change_column :restaurants, :prefecture, :string, null: false
    # change_column :restaurants, :city, :string, null: false
    # change_column :restaurants, :street, :string, null: false
  end

  def down
    change_column :contacts, :email, :string, null: true
    change_column :contacts, :message, :text, null: true
    change_column :menus, :restaurant_id, :integer, null: true
    change_column :menus, :title, :string, null: true
    change_column :menus, :regular_price, :integer, null: true
    change_column :menus, :discount_price, :integer, null: true
    change_column :menus, :reservation_method, :integer, null: true
    change_column :reservations, :user_id, :integer, null: true
    change_column :reservations, :menu_id, :integer, null: true
    change_column :reservations, :reservation_year, :integer, null: true
    change_column :reservations, :reservation_month, :string, null: true
    change_column :reservations, :reservation_day, :string, null: true
    change_column :reservations, :reservation_time, :string, null: true
    change_column :reservations, :people, :integer, null: true
    # change_column :restaurants, :prefecture, :string, null: true
    # change_column :restaurants, :city, :string, null: true
    # change_column :restaurants, :street, :string, null: true
  end

end
