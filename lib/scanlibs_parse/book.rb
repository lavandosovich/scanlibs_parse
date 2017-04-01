class Book
  def self.to_attr method
    attr_accessor method.to_sym
  end

  def initialize params
    params.each do |method, value|
      self.class.to_attr method
      self.send("#{method.to_s}=", value)
    end
  end
end