require './lib/canvas_error'

class Canvas
  MAX_SIZE = 250
  DEFAULT_COLOUR = 'O'
  DEFAULT_SIZE = 1

  def initialize(options = {x: DEFAULT_SIZE, y: DEFAULT_SIZE})
    raise CanvasError.too_big if too_big?(options[:x], options[:y])
    rows = ->{Array.new(options[:x].to_i, DEFAULT_COLOUR)}
    @board = Array.new(options[:y].to_i) {rows.call}
  end

  def fill(x, y, colour)
   raise CanvasError.out_of_boundaries unless board.dig(x.to_i, y.to_i)
    @board[x.to_i][y.to_i] = colour
  end

  def vertical_line(column, from, to, colour )
    fill_all((from..to).map{|axis| [axis, column]}, colour)
  end

  def horizontal_line(row, from, to, colour)
    fill_all((from..to).map{|axis|[row, axis]}, colour)
  end

  def board
    @board.dup
  end

  def show
    board.each{|row|STDOUT.puts(row.to_s)}
  end

  def clear
    @board.each{|row|row.map!{|pixel| pixel = DEFAULT_COLOUR}}
  end

  private
  def fill_all(pixels, colour)
    pixels.each{|pixel| fill(*pixel, colour)}
  end

  def too_big?(x,y)
    (x.to_i > MAX_SIZE || y.to_i > MAX_SIZE)
  end
end
