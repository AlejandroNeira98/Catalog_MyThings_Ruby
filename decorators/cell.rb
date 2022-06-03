class Cell
  def initialize(string, length = 16)
    @length = length
    @string = string
  end

  def to_s(*params)
    return "#{@string.to_s(*params).ljust(@length - 1)}|" if @string.to_s.length + 1 < @length

    "#{@string.to_s(*params).ljust(@length)[0..(@length - 4)]}...|"
  end
end
