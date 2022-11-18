class Flight

  attr_reader :passengers

  def initialize(flnum, capacity)
    @flight_number = flnum
    @capacity = capacity
    @passengers = []
  end

  def full?()
    return @passengers.length >= @capacity
  end

  def board_passenger(pass)
    @passengers << pass if !full? && pass.has_flight?(@flight_number)
  end

  def list_passengers
    @passengers.map { |passenger| passenger.name}
  end

  def [](idx)
    @passengers[idx]
  end

  def <<(pass)
    board_passenger(pass)
  end
end