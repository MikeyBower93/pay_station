defmodule PayStation.Payments.External.Transaction do
  @derive Jason.Encoder
  defstruct [:id, :quantity, :card_id, :merchant]
end
