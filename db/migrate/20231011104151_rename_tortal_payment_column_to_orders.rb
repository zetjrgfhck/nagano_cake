class RenameTortalPaymentColumnToOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :tortal_payment, :total_payment
  end
end
