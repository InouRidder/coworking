class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.references :registration, null: false, foreign_key: true
      t.string :status, default: 'active'

      t.timestamps
    end
  end
end
