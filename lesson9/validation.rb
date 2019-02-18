# frozen_string_literal: true

module Validation
  def valid?
    validate!
    true
  rescue ArgumentError
    false
  end

  protected

  def validate!; end
end
