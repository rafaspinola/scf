module PaymentDocumentsHelper
  def self.payment_method_description(payment_method)
    if payment_method == "B"
      return "Boleto"
    end
    if payment_method == "C"
      return "Cheque"
    end
  end
end
