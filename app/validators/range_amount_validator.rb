class RangeAmountValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    return if value.nil?

    allow_decimals = options.fetch(:currency)
    regex_chars    = allow_decimals ? "0-9:+." : "0-9:+"

    unless value.match?(/\A[#{regex_chars}]+\+?\z/)
      record.errors.add(attr, "contains invalid characters")
      return
    end

    plus  = value.end_with?("+")
    core  = plus ? value.chop : value
    parts = core.split(":")

    unless (1..2).cover?(parts.size) && parts.none?(&:blank?)
      record.errors.add(attr, "invalid range format")
      return
    end

    amounts = parts.map { |p| BigDecimal(p, 10) rescue nil }

    if amounts.any?(&:nil?) || amounts.any?(&:negative?)
      record.errors.add(attr, "amounts must be >= 0")
      return
    end

    if parts.size == 2 && amounts[1] <= amounts[0]
      record.errors.add(attr, "end must be greater than start")
    end
  end
end
