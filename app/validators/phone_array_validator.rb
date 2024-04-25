class PhoneArrayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.all? { |phone| phone.match?(/\A\d{10}\z/) }
      record.errors.add attribute, (options[:message] || "is not a valid phone number format")
    end
  end
end

