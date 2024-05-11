
require_relative 'Logger'
require_relative 'user'
require_relative 'transaction'
require_relative 'cba_bank'

bank_users = [
  User.new("Mohamed", 10),
  User.new("ahmed", 0),
  User.new("test", 50)
]

outside_users = [
  User.new("gharabawy",0),
  User.new("test2",30)
]

transactions = [
  Transaction.new(bank_users[0], 10),
  Transaction.new(bank_users[1], -1),
  Transaction.new(bank_users[2], 30),
  Transaction.new(outside_users[0], 100),
  Transaction.new(outside_users[1], 400)
]

cba_bank = CBABank.new

cba_bank.process_transactions(transactions, bank_users) do |status, transaction|
  puts "Transaction with user #{transaction.user.name} was #{status}"

  if status == "success"
    puts "User #{transaction.user.name} balance is #{transaction.user.balance}"
  elsif status == "failure"
    puts "User #{transaction.user.name} balance is #{transaction.user.balance}"
  end
end
