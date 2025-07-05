class PhoneValidator < ActiveModel::EachValidator
  FORMAT = /\A[2-9]\d{2}[2-9]\d{6}\z/

  def validate_each(record, attr, value)
    return if value.nil?

    unless value.match?(FORMAT)
      record.errors.add(attr, "must be in NANP format of XXXXXXXXXX")
      nil
    end
  end
end
