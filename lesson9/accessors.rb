module Accessors
  def attr_accessor_with_history(*attrs)
    attrs.each do |attr|
      raise TypeError, 'method name is not symbol' unless attr.is_a?(Symbol)

      add_attr_history_accessors(attr)
      add_attr_accessors(attr)
    end
  end

  def strong_attr_accessor(attr, class_name)
    raise TypeError, 'method name is not symbol' unless attr.is_a?(Symbol)

    attr_reader attr
    define_method("#{attr}=") do |value|
      raise TypeError, "#{value} is not of type #{class_name}" unless value.is_a?(class_name)

      instance_variable_set "@#{attr}", value
    end
  end

  private

  def add_attr_accessors(attr)
    attr_reader attr
    define_method("#{attr}=") do |value|
      instance_variable_set "@#{attr}", value
      instance_eval "self.#{attr}_history = #{value}", __FILE__, __LINE__
    end
  end

  def add_attr_history_accessors(attr)
    attr_history = "#{attr}_history"
    var_history = "@#{attr_history}"

    define_method(attr_history) { instance_variable_get(var_history) || [] }
    define_method("#{attr_history}=") do |value|
      history = instance_eval attr_history, __FILE__, __LINE__
      instance_variable_set var_history, history << value
    end

    private "#{attr_history}=".to_sym
  end
end
