module ApplicationHelper
  def ntc(value)
    number_to_currency(value, :format => "%u %n", :separator => ",", :delimiter => ".", :unit => "R$")
  end
end
