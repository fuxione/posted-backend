class CreateLeads < ActiveRecord::Migration[8.0]
  def change
    create_table :leads, id: :uuid do |t|
      # REQUEST FIELDS
      t.string :host,       null: false
      t.string :path,       null: false
      t.jsonb  :query,      null: false, default: {}
      t.string :ip_address, null: false
      t.string :referrer
      t.string :user_agent

      # USER_FIELDS
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

      # META_FIELDS
      t.jsonb :meta_fields, default: {}

      # INTERNAL_FIELDS
      t.string :vertical, null: false
      t.string :txid
      t.string :jornaya_id
      t.string :tcpa_language
      t.string :fcra_language

      t.timestamps
    end
  end
end
