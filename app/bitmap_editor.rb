require './lib/bitmap_canvas_rules'

class BitmapEditor

  def run
    @running = true
    bitmap_cavas_rules =  BitmapCanvasRules.new
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp.upcase
      case input
        when '?'
          show_help
        when 'X'
          exit_console
        else
          begin
           bitmap_cavas_rules.process(input)
         rescue CanvasError, ArgumentError => e
           STDOUT.puts("#{e.class} : #{e.message}")
           show_help if e.is_a?(ArgumentError)
          end
      end
    end
  end

  private
    def exit_console
      puts 'goodbye!'
      @running = false
    end

    def show_help
      puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session"
    end
end
