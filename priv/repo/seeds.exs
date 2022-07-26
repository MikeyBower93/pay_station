PayStation.Repo.query!("ALTER SEQUENCE card_holders_id_seq RESTART WITH 1")
PayStation.Repo.delete_all(PayStation.Expenses.CardHolder)
PayStation.Repo.delete_all(PayStation.Expenses.Company)

record_company = PayStation.Repo.insert!(%PayStation.Expenses.Company{
  name: "House of records Ltd"
})

vegetable_company = PayStation.Repo.insert!(%PayStation.Expenses.Company{
  name: "Organic Veg Ltd"
})

Enum.each(1..10, fn _ ->
  PayStation.Repo.insert!(%PayStation.Expenses.CardHolder{
    name: Faker.Person.name,
    company_id: Faker.Util.pick([record_company.id, vegetable_company.id])
  })
end)
