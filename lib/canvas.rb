require './lib/errors/canvas_error'
class Canvas
  MAX_SIZE = 250
  DEFAULT_COLOUR = 'O'
  DEFAULT_SIZE = 1

  def initialize(options = {x: DEFAULT_SIZE, y: DEFAULT_SIZE})
    raise CanvasError.too_big if too_big?(options[:x], options[:y])
    rows = ->{Array.new(options[:x].to_i.abs, DEFAULT_COLOUR)}
    @board = Array.new(options[:y].to_i.abs) {rows.call}
  end

  def fill(x, y, colour)
    raise CanvasError.out_of_boundaries unless board[y.to_i][x.to_i]
    @board[y.to_i][x.to_i] = colour
  end

  def vertical_line(column, from, to, colour)
    fill_all((from..to).map{|axis|[column, axis]}, colour)
  end

  def horizontal_line(from, to, row, colour)
    fill_all((from..to).map{|axis| [axis, row]}, colour)
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

  def surrounding_squares(coords)
    coords.map{|i| [i - 1, i , i + 1 ]}.flatten.combination(2).to_a.uniq
  end

  def surrounding_squares_on_board(coords)
    surrounding_squares(coords).reject{|coord|coord.any?(&:negative?)}
  end

  def surrounding_same_colour_squares_on_board(coords)
    surrounding_squares_on_board(coords).select{|c| colour(c) == colour(coords)}
  end

  def colour(coords)
    board.dig(*coords)
  end

  private
  def fill_all(pixels, colour)
    pixels.each{|pixel| fill(*pixel, colour)}
  end

  def too_big?(x,y)
    (x.to_i.abs > MAX_SIZE || y.to_i.abs > MAX_SIZE)
  end
end
