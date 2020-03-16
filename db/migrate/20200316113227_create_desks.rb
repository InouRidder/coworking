class CreateDesks < ActiveRecord::Migration[6.0]
  def change
    create_table :desks do |t|
      t.string :name
      t.integer :price_per_day

      t.timestamps
    end
  end
end
