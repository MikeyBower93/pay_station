defmodule PayStation.Payments.External.PaymentProcessor do
  alias PayStation.Payments.External.Transaction

  def fetch_payments do
    0..Faker.random_between(0, 100)
    |> Enum.map(fn _seed ->
        %Transaction{
          id: Faker.UUID.v4(),
          quantity: Faker.random_between(0, 1_000_000),
          card_id: Faker.random_between(0, 10),
          merchant: Faker.Company.name
        }
    end)
  end
end
