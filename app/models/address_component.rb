class AddressComponent
  attr_reader :long_name, :short_name, :types

  def initialize(params)
    [:long_name, :short_name, :types].each do |sym|
      instance_variable_set("@#{sym}".to_sym, params[sym])
    end
  end
end