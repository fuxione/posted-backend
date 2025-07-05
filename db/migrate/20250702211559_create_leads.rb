class CreateLeads < ActiveRecord::Migration[8.0]
  def change
    create_table :leads, id: :uuid do |t|
      t.integer :wid,      null: false
      t.string  :vertical, null: false

      # request fields
      t.string :host,       null: false
      t.string :path,       null: false
      t.jsonb  :query,      null: false, default: {}
      t.string :ip_address, null: false

      # profile
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
      t.string :ssn

      # loan
      t.string :loan_amount
      t.string :debt_amount
      t.string :monthly_income
      t.string :employment_status
      t.string :employment_pay_frequency
      t.string :credit_score

      # meta fields
      t.jsonb :meta_fields, default: {}

      # tracking
      t.string :txid
      t.string :jornaya_id

      # consent
      t.string :tcpa_language
      t.string :fcra_language

      # request metadata
      t.string :referrer
      t.string :user_agent

      t.timestamps
    end
  end
end
