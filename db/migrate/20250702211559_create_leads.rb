class CreateLeads < ActiveRecord::Migration[8.0]
  def change
    create_table :leads, id: :uuid do |t|
      t.string :host,       null: false
      t.string :path,       null: false
      t.jsonb  :query,      null: false, default: {}
      t.string :referrer
      t.string :ip_address, null: false
      t.string :user_agent

      # INTERNAL_FIELDS
      # ===============

      t.string :txid
      t.string :jornaya_id

      # USER_FIELDS
      # ===========

      # consent
      t.string :tcpa_language
      t.string :fcra_language

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

      # loan
      t.string :loan_amount
      t.string :ssn

      # META_FIELDS
      t.jsonb :meta_fields, default: {}

      t.timestamps
    end
  end
end
