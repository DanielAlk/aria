class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :transaction_amount, precision: 8, scale: 2
      t.integer :installments, default: 1
      t.decimal :shipment_cost, precision: 8, scale: 2
      t.string :payment_method_id
      t.string :token
      t.text :additional_info
      t.text :mercadopago_payment
      t.integer :mercadopago_payment_id
      t.string :status
      t.string :status_detail
      t.references :zone, index: true, foreign_key: true
      t.boolean :save_address, default: false
      t.boolean :save_card, default: false

      t.timestamps null: false
    end
  end
end
