class CreateLeads < ActiveRecord::Migration[8.0]
  def change
    create_table :leads, id: :uuid do |t|
      # lead creation fields (required)
      t.string :host, null: false
      t.string :path, null: false
      t.string :query, null: false
      t.string :referrer, null: false
      t.string :user_agent, null: false
      t.string :ip_address, null: false

      # personal form fields
      t.string :first_name, null: true
      t.string :last_name, null: true
      t.string :email, null: true
      t.string :primary_phone, null: true
      t.string :work_phone, null: true
      t.string :address1, null: true
      t.string :address2, null: true
      t.string :city, null: true
      t.string :state, null: true
      t.string :zip, null: true
      t.string :country, null: true
      t.string :date_of_birth, null: true

      # loan fields
      t.string :loan_types, array: true, null: true         # https://engine.tech/docs/api-reference/#tocS_LoanPurpose (array of strings - ["home_improvement", "medical_expenses"])
      t.string :loan_amount, null: true                     # "2000.00:5000.00" => [min:max], ":2000.00+" => max+, "-1000:00:" => min-
      t.string :ssn, null: true

      # tracking fields
      t.string :jornaya_id, null: true
      t.boolean :tcpa_consent, null: true
      t.boolean :fcra_consent, null: true
      t.text :tcpa_language, null: true
      t.text :fcra_language, null: true

      t.timestamps
    end
  end
end
