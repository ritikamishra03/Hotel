class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.references :bookings, null: false, foreign_key: true
      t.decimal :total_amount, precision: 10, scale: 2
      t.string :status, default: 'unpaid'
      t.date :issued_at

      t.timestamps
    end
  end
end