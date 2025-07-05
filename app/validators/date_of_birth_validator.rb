class DateOfBirthValidator < ActiveModel::EachValidator
  MIN_AGE = 18.years
  MAX_AGE = 100.years

  def validate_each(record, attr, value)
    return if value.nil?

    date = Date.iso8601(value) rescue nil
    return record.errors.add(attr, "must be YYYY-MM-DD") if date.blank?

    today = Time.zone.today
    record.errors.add(attr, "must be at least #{MIN_AGE}")    if date > today - MIN_AGE
    record.errors.add(attr, "can’t be older than #{MAX_AGE}") if date < today - MAX_AGE
  end
end
