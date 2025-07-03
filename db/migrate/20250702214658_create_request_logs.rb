class CreateRequestLogs < ActiveRecord::Migration[8.0]
  def change
    # logging app requests
    # 1. lead <-> buyers_stack => buyer
    # 2. lead <-> providers
    create_table :request_logs do |t|
      t.references :lead, null: false, foreign_key: true, type: :uuid

      # either provider or buyer
      t.references :provider, null: true, foreign_key: true
      t.references :buyer, null: true, foreign_key: true

      # logging fields
      t.integer :status_code, null: false
      t.string :method, null: false
      t.boolean :success, null: false
      t.string :url, null: false
      t.text :request_body, null: false
      t.text :response_body, null: false
      t.decimal :total_time, precision: 10, scale: 3, null: false # milliseconds precision 0.001
      t.jsonb :metadata, null: false

      t.timestamps
    end

    # ensure that either provider or buyer is set
    add_check_constraint :request_logs,
      "(provider_id IS NOT NULL AND buyer_id IS NULL) OR (provider_id IS NULL AND buyer_id IS NOT NULL)",
      name: "request_logs_exactly_one_target"
  end
end
