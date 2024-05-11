
class Bank
  def process_transactions(transactions, users, &callback)
    raise NotImplementedError, 'This method must be implemented in a subclass'
  end
end
