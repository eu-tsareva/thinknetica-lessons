# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
  end

  def valid?
    validate!
    true
  rescue ArgumentError, TypeError, RegexpError
    false
  end

  def validate!
    self.class.validations.each do |val|
      send(
        "validate_#{val[:option]}".to_sym,
        instance_variable_get("@#{val[:attr]}"),
        val[:value]
      )
    end
    nil
  end

  private

  def validate_presence(attr, _value)
    raise ArgumentError, 'Can\'t be null or empty!' if blank?(attr)
  end

  def validate_type(attr, type)
    return unless attr
    raise TypeError, "Should be of type #{type}" unless attr.is_a?(type)
  end

  def validate_format(attr, format)
    return unless attr
    raise RegexpError, 'Wrong format!' unless attr =~ format
  end

  def blank?(attr)
    return attr.nil? if attr.is_a?(Integer)

    attr.nil? || attr.empty?
  end

  module ClassMethods
    def validate(attr, option, value = nil)
      @validations = validations << { attr: attr, option: option, value: value }
    end

    def validations
      @validations || []
    end
  end
end
