class Canvas
  MAX_SIZE = 250
  DEFAULT_COLOUR = 'O'
  DEFAULT_SIZE = 1

  def initialize(options = {x: DEFAULT_SIZE, y: DEFAULT_SIZE})
    raise "too big" if (options[:x].to_i > MAX_SIZE || options[:y].to_i > MAX_SIZE)
    rows = ->{Array.new(options.fetch(:x, DEFAULT_SIZE).to_i, DEFAULT_COLOUR)}
    @board = Array.new(options.fetch(:y, DEFAULT_SIZE).to_i) {rows.call}
  end

  def fill(x, y, colour)
    raise "out of boundaries" unless board.dig(x.to_i,y.to_i)
    board[x.to_i][y.to_i] = colour
  end

  def vertical_line(initial, start, stop, colour )
    (start..stop).each{|axis| fill(axis, initial, colour)}
  end

  def horizontal_line(initial, start, stop, colour)
    (start..stop).each{|axis| fill(initial, axis, colour)}
  end

  def board
    @board.dup
  end

  def show
    board.each {|row|STDOUT.puts(row.to_s)}
  end

  def clear
    @board.each{|row|row.map!{|pixel| pixel = DEFAULT_COLOUR}}
  end
end
