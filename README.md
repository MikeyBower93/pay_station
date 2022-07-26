# PayStation

## Intro

This is a project used to demonstrate how you can use a message queue (kafka in this case), to keep low coupling in an elixir monolith, using contexts/domain driven development.

This is using a business case that I have professional experience with, which is in FinTech, specifically regarding company expenses. The basic logic is as follows. Card holders/employees of companies can make expenses with a card, which will bill the company they work for. An accountant can then review the expense and determine whether its a company expense which company has to pay for, or whether its actually a personal expense and will come out the employees payslip.

The domain driven design/context part comes into play as we have 2 separate parts in this project. The platform that can recieve payments/transactions from a payment processor, and intake those transactions into our system, however at this point/context there is no correlation between a transaction and an expense, and in fact there shouldn't be, as in the future this could easily change, where transactions could be related to things beyond expenses.

There is then an expenses domain, that is responsible for company expenses, which is related to a company, card holder and expense, whereby an expense can then be reviewed by someone, at a specific time, and set as a company expense (or not). 

However the expense domain is dependant on the transactions being created by in the payment context. However its crucial we do not call the expenses domain from tha transactions domain, as this will break domain driven development by creating coupling between the payment and expense domain.

We solve this in a robust an loosely coupled manner by using kafka to have a message queue between the 2.

## How to run

1. Install `asdf` and specifically the `elixir` and `erlang` plugin.
2. Run `asdf install` which will install the versions.
3. Run `docker compose up`, this will start the services (`postgres` and `kafka` locally).
4. Run `setup.sh` which will create the topic in kafka.
5. Run `mix phx.server` to start the server.

## Running on WSL
- Build essentials needed `sudo apt-get install build-essential`