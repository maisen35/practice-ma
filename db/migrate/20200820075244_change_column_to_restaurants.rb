class ChangeColumnToRestaurants < ActiveRecord::Migration[5.2]

  def up
    # 住所の詳細カラムを追加
    add_column :restaurants, :prefecture, :string
    add_column :restaurants, :city, :string
    add_column :restaurants, :street, :string
    add_column :restaurants, :building, :string

    # 住所カラムの削除
    remove_column :restaurants, :address
  end

  def down
    remove_column :restaurants, :prefecture
    remove_column :restaurants, :city
    remove_column :restaurants, :street
    remove_column :restaurants, :building

    add_column :restaurants, :address, :string
  end

end
