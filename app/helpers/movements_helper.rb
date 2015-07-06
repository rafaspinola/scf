module MovementsHelper
end

class MovementTransferenceValidator < ActiveModel::Validator
  def validate(record)
    if record.transfer && record.to_bank.empty?
      record.errors[:base] = "Toda transferência deve indicar para qual banco"
    end
  end
end