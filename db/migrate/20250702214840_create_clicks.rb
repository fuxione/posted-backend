class CreateClicks < ActiveRecord::Migration[8.0]
  def change
    create_table :clicks do |t|
      t.references :lead, null: false, foreign_key: true, type: :uuid

      # click fields
      t.string :ip_address, null: false
      t.string :user_agent, null: false
      t.string :referrer, null: false
      t.string :current_url, null: false
      t.string :next_url, null: false

      t.timestamps
    end
  end
end
