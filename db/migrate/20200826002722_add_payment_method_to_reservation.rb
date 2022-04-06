class AddPaymentMethodToReservation < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :payment_method, :integer, default: 0
  end
end
