module Concerns
  module Creatable
    def initialize params
      params.each do |method, value|
        self.class.send :attr_accessor, method.to_sym
        self.send("#{method.to_s}=", value)
      end
    end
  end
end