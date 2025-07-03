class CreateStackResults < ActiveRecord::Migration[8.0]
  def change
    create_table :stack_results do |t|
      # lead <->stack<->buyer are required (there shoule be a log entry before adding stack result)
      t.references :lead, null: false, foreign_key: true, type: :uuid
      t.references :buyers_stack, null: false, foreign_key: true
      t.references :buyer, null: false, foreign_key: true
      t.references :request_log, null: false, foreign_key: true

      t.jsonb :stack_snapshot, null: false # snapshot of the stack at the time of the request (buyer_stack.config)

      # result fields
      t.string :status, null: false # ["winner", "error", "timeout"]
      t.decimal :final_price, precision: 10, scale: 2, null: false
      t.string :final_response_body, null: false
      t.string :offer_type, null: false

      t.datetime :won_at, null: true # only for "winner" status

      t.timestamps
    end
  end
end
