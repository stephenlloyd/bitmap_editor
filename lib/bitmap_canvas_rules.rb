require './lib/canvas'
class BitmapCanvasRules
  METHODS = {"C" => :clear, "L" => :fill, "V" => :vertical_line,
            "H" => :horizontal_line, "S" => :show}

  attr_reader :canvas

  def initialize(options = {})
    @canvas_klass = options.fetch(:canvas, Canvas)
  end

  def process(command)
    create_canvas(x: $1, y: $2) if command.match(/I (\d+) (\d+)/)
    STDOUT.puts("You must create a canvas first, try \"I 5 5\"") unless canvas
    method, *arguments = command.split(" ")
    canvas.send(METHODS[method], *arguments) unless method.eql?("I") || !canvas
  end

  private
  def create_canvas(x:, y:)
    @canvas = @canvas_klass.new({x: x, y: y})
  end
end
