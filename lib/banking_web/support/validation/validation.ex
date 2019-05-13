defmodule BankingWeb.Support.Validation do

  def validate_required(params, value) do
    Map.has_key?(params, value)
  end

  def validate_is_not_negative(_, value) do
    if value < 0.00 do
      false
    else
      true
    end
  end

  def validate(params_validations, params) do
    for param_validation <- params_validations do
      {attr, validations} = param_validation
      for validation <- validations do
        case validation do
          :required ->
            if !validate_required(params, Atom.to_string(attr))do
              raise "#{attr} can't be blank"
            end
          :is_not_negative ->
            if !validate_is_not_negative(params, params[Atom.to_string(attr)])do
              raise "#{attr} can't be negative"
            end
        end
      end
    end
    {:ok}
  end

end
