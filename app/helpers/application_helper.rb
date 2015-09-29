module ApplicationHelper
  def ntc(value)
    number_to_currency(value, :format => "%u %n", :separator => ",", :delimiter => ".", :unit => "R$")
  end

    def clear_number(data)
    data.gsub(/[^\d]/, "")
  end

  def format_phone(data)
    data = clear_number(data)
    m = data.match(/(\d{2})(\d{4,5})(\d{4})/)
    if m == nil
      r = data
    else
      r = "(#{m[1]}) #{m[2]}-#{m[3]}"
    end
    r
  end

  def format_postal_code(data)
    data = clear_number(data)
    debugger
    m = data.match(/(\d{2})(\d{3})(\d{3})/)
    if m == nil
      r = data
    else
      r = "#{m[1]}.#{m[2]}-#{m[3]}"
    end
    r
  end

  def format_cpf(data)
    data = clear_number(data)
    m = data.match(/(\d{3})(\d{3})(\d{3})(\d{2})/)
    if m == nil
      data
    else
      "#{m[1]}.#{m[2]}.#{m[3]}-#{m[4]}"
    end
  end

  def format_cnpj(data)
    data = clear_number(data)
    m = data.match(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/)
    if m == nil
      data
    else
      "#{m[1]}.#{m[2]}.#{m[3]}/#{m[4]}-#{m[5]}"
    end
  end
end
