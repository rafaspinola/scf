class Course < ActiveRecord::Base

  has_many :course_classes
  has_many :prices

  validates :payment_identifier, uniqueness: true, length: { maximum: 1 }

  def to_s
    self.code
  end

  # def get_price_list
  #   prices = [
  #     build_total_price_item(6, self.price6),
  #     build_total_price_item(5, self.price5),
  #     build_total_price_item(4, self.price4),
  #     build_total_price_item(3, self.price3),
  #     build_total_price_item(2, self.price2),
  #     build_total_price_item(1, self.price)
  #   ]
  # end

  def build_total_price_item(number_of_payments, payment_value)
    total_value = number_of_payments * payment_value
    {id: total_value, value: build_price_string(number_of_payments, payment_value, total_value)}
  end

  def build_price_string(number_of_payments, payment_value, total_value)
    number_of_payments = number_of_payments - 1
    if number_of_payments == 0
      "R$ #{total_value} à vista"
    else
      "Entrada + #{number_of_payments} parcela".pluralize(number_of_payments) + " de R$ #{payment_value} - Total R$ #{total_value}"
    end
  end

  def get_payments_quantity(total_amount)
    return 6 if (total_amount/6) == self.price6
    return 5 if (total_amount/5) == self.price5
    return 4 if (total_amount/4) == self.price4
    return 3 if (total_amount/3) == self.price3
    return 2 if (total_amount/2) == self.price2
    return 1 if total_amount == self.price   
  end
end
