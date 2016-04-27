class Canvas

  DEFAULT_COLOUR = 'O'
  DEFAULT_SIZE = 1

  def initialize(options = {})
    rows = proc{Array.new(options.fetch(:x, DEFAULT_SIZE), DEFAULT_COLOUR)}
    @board = Array.new(options.fetch(:y, DEFAULT_SIZE)) {rows.call}
  end


  def fill(options)
    raise "out of boundaries" unless board.dig(options[:x], options[:y])
    @board[options[:x]][options[:y]] = options[:colour]
  end

  def board
    @board.dup
  end


end
