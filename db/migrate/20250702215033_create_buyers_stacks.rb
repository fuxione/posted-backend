class CreateBuyersStacks < ActiveRecord::Migration[8.0]
  def change
    create_table :buyers_stacks do |t|
      t.string :description, null: false

      # "a" await / "p" min_price
      # [{"a":[{"id":1},{"id":3},{"id":2}], "p":2}, {{"a":[{"id":1}], "p":null}, {{"a":[], "p":null}]
      t.jsonb :config, null: false

      t.timestamps
    end
  end
end
