class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :status, default: 'unconfirmed'
      t.references :registration
      t.string :token
      t.date :last_confirmation_email_sent_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.date :last_confirmed_at, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
