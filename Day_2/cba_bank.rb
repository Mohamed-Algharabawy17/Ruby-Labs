require_relative 'Logger'
require_relative 'bank'

class CBABank < Bank
  include Logger

  def process_transactions(transactions, users, &callback)
    transactions.each do |transaction|
      begin
        if transaction.user.balance + transaction.value < 0
          raise "Not enough balance"
        elsif !users.include?(transaction.user)
          raise "#{transaction.user.name} not exist in the bank!!"
        else
          if transaction.user.balance == 0
            log_warning("#{transaction.user.name} has 0 balance")
          end
          transaction.user.balance += transaction.value
          log_info("User #{transaction.user.name} transaction with value #{transaction.value} succeeded")
          callback.call("success", transaction)
        end
      rescue => e
        log_error("User #{transaction.user.name} transaction with value #{transaction.value} failed with message #{e.message}")
        callback.call("failure", transaction)
      end
    end
  end
end
