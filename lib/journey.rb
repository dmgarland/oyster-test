class Journey

  Fare = Struct.new(:value, :zone)
  MAX_FARE = 320
  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def tap_in(zone:)
    @transactions << Fare.new(MAX_FARE, zone)
  end

  FARES = {
    [1] =>  250,
    [2] =>  200,
    [3] =>  200,
    [1, 2, 3] =>  320,
    [2, 3] =>  225,
    [1, 2] =>  300,
    [1, 3] =>  300,
  }

  def tap_out(zone:)
    last_transaction = @transactions.pop
    @transactions << Fare.new(FARES[[last_transaction.zone, zone].sort.uniq])
  end
end
