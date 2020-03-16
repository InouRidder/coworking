class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.timestamp :start_date
      t.timestamp :end_date
      t.string :status, default: 'unpaid'
      t.integer :total_price
      t.references :user, null: false, foreign_key: true
      t.references :desk, null: false, foreign_key: true

      t.timestamps
    end
  end
end
