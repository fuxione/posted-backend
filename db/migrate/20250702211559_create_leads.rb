class CreateLeads < ActiveRecord::Migration[8.0]
  def change
    create_table :leads, id: :uuid do |t|
      # CREATE
      t.string :host,       null: false
      t.string :path,       null: false
      t.jsonb  :query,      null: false, default: {}
      t.string :ip_address, null: false
      t.string :referrer
      t.string :user_agent

      # UI "ATTRIBUTES"
      t.string :txid
      t.string :jornaya_id

      # UI "FIELDS"
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :work_phone
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :date_of_birth

      # loan fields
      t.string :loan_types, array: true #  https://engine.tech/docs/api-reference/#tocS_LoanPurpose (array      of strings -           ["home_improvement", "medical_expenses"])
      t.string :loan_amount             #  3 formats: n, min:max, n+
      t.string :ssn

      # consent fields
      t.boolean :tcpa_consent
      t.boolean :fcra_consent
      t.string  :tcpa_language
      t.string  :fcra_language

      t.timestamps
    end
  end
end
