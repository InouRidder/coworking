class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :status, default: 'unconfirmed'
      t.references :registration
      t.date :last_confirmed_at

      t.timestamps
    end
  end
end
