class CreateBuyers < ActiveRecord::Migration[8.0]
  def change
    create_table :buyers do |t|
      t.string :name, null: false
      t.string :representative_name, null: false, default: ""
      t.boolean :enabled, null: false, default: true
      t.decimal :price, null: false, default: 0.0

      # ringba fields & everflow offer id
      t.string :ringba_phone, null: true
      t.string :ringba_url, null: true
      t.string :everflow_oid, null: true

      # buyer payout type
      t.string :payout_event, null: true # api(lead sold), redirect, click


      # conditions
      t.jsonb :exclude_conditions, null: true
      t.jsonb :include_conditions, null: true
      t.integer :daily_cap, null: false, default: -1 # -1 is no-cap (unlimited)
    end
  end
end
