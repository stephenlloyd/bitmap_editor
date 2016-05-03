require './lib/errors/canvas_error'
class Canvas
  MAX_SIZE = 250
  DEFAULT_COLOUR = 'O'
  DEFAULT_SIZE = 1

  def initialize(options = {x: DEFAULT_SIZE, y: DEFAULT_SIZE})
    raise CanvasError.too_big(MAX_SIZE) if too_big?(options[:x], options[:y])
    rows = ->{Array.new(options[:x].to_i.abs, DEFAULT_COLOUR)}
    @board = Array.new(options[:y].to_i.abs) {rows.call}
  end

  def fill(x, y, colour)
    raise CanvasError.out_of_boundaries if not_on_board?([y.to_i, x.to_i])
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
    board.each{|row|row.map!{|pixel| pixel = DEFAULT_COLOUR}}
  end

  def fill_area(x, y, colour)
    fill_all(all_area([x.to_i, y.to_i]), colour)
  end

  private

  def surrounding_squares(coords)
    bounds = coords.map{|i| [i - 1, i , i + 1 ]}
    normalize_coords(bounds.first.map{|i| bounds.last.map{|l_i|[i, l_i]}})
  end

  def all_area(coords)
    all_coords = all_surrounding_coords_of_same_colour(normalize_coords(coords))
    return coords if coords == normalize_coords(all_coords)
    all_area(normalize_coords(all_coords))
  end

  def all_surrounding_coords_of_same_colour(coords)
    coords.map{|c|surrounding_same_colour_squares_on_board(c)}
  end

  def surrounding_same_colour_squares_on_board(coords)
    surrounding_squares_on_board(coords).select {|c|colour(c) ==  colour(coords)}
  end

  def surrounding_squares_on_board(coords)
    inside_board_boundaries(surrounding_squares(coords))
  end

  def inside_board_boundaries(coords)
    coords.reject(&negative_indexes).reject(&bigger_than_the_board)
  end

  def colour(coords)
    board.dig(*coords.reverse)
  end


  def negative_indexes
    -> (x){x.any?(&:negative?)}
  end

  def bigger_than_the_board
    -> (x){not_on_board?(x.reverse)}
  end

  def not_on_board?(coord)
    board.dig(*coord).nil?
  end

  def fill_all(pixels, colour)
    pixels.each{|pixel| fill(*pixel, colour)}
  end

  def too_big?(x,y)
    (x.to_i.abs > MAX_SIZE || y.to_i.abs > MAX_SIZE)
  end

  def normalize_coords(coords)
    coords.flatten.each_slice(2).to_a.uniq
  end
end
