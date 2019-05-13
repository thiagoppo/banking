defmodule BankingWeb.Support.ValidationTest do
  use ExUnit.Case, async: true
  alias BankingWeb.Support.Validation

  describe "validate_required/2" do
    test "there must be a key" do
      params = %{"destiny_account_id" => 1}

      assert Validation.validate_required(params, "destiny_account_id") === true
    end

    test "there should be no key" do
      params = %{"account_id" => 1}

      assert Validation.validate_required(params, "destiny_account_id") === false
    end
  end

  describe "validate_is_not_negative/2" do
    test "the value must be positive" do
      assert Validation.validate_is_not_negative(%{}, 10.00) === true
    end

    test "the value must be negative" do
      assert Validation.validate_is_not_negative(%{}, -10.00) === false
    end
  end

  describe "validate/2" do
    test "should successfully validate" do
      params_validations = %{destiny_account_id: [:required]}
      params = %{"destiny_account_id" => 1}

      assert {:ok} = Validation.validate(params_validations, params)
    end

    test "should throw exception when validation is false" do
      params_validations = %{destiny_account_id: [:required]}
      params = %{"account_id" => 1}

      assert_raise RuntimeError, "destiny_account_id can't be blank", fn ->
        Validation.validate(params_validations, params)
      end
    end
  end

end
