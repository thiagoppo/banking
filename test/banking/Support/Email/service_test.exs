defmodule Banking.Support.Email.EmailServiceTest do
  use ExUnit.Case, async: true
  alias Banking.Support.Email.EmailService

  describe "send/1" do
    test "should send email successfully" do
      assert EmailService.send("Email") == :ok
    end
  end

end
