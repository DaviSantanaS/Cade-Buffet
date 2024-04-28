class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless CPF.valid?(value)
      record.errors.add(attribute, :invalid, message: 'is not a valid CPF')
    end
  end
end