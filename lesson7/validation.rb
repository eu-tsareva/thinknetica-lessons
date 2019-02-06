module Validation
  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!; end
end
