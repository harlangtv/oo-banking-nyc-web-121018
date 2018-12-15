class Transfer

  attr_accessor :sender, :receiver, :amount, :status

  @@all = []

  def self.all
    @@all
  end

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    ## 1. can check that both accounts are valid
    ## 2. calls on the sender and receiver's #valid? methods
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    ## 1. can execute a successful transaction between two accounts
    ## 2. each transfer can only happen once
    ## 3. rejects a transfer if the sender doesn't have a valid account
    ## We need 3 scenarios (increment, decrement, and create new transaction)
    if sender.balance > amount && self.status == "pending"
      ## decrement sender.balance
      sender.balance -= amount
      ## increment sender.balance
      receiver.balance += amount
      ## create new transaction
      @status = "complete"
      ## stores the transaction
      @@all << self
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    ## 1. can reverse a transfer between two accounts
    ## 2. it can only reverse executed transfers
    ## needs to look in stored transfers
    transaction = @@all.last
    ## and reverse one transfer (the last one)
    if transaction.status == "complete"
      transaction.sender.balance += transaction.amount
      transaction.receiver.balance -= transaction.amount
      transaction.status = "reversed"
    end
  end

end # end of Transfer class
