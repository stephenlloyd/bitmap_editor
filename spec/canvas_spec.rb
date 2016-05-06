require 'canvas'

describe Canvas do
  let(:subject){described_class.new({x: '4', y: '3'})}

  it "creates a blank canvas with default colour" do
    expect(described_class.new.board).to eq [[Canvas::DEFAULT_COLOUR]]
  end

  it "can't create a grid outside of its max size for x axis" do
    expect{described_class.new({x: Canvas::MAX_SIZE + 1, y: 1})}.to raise_error(CanvasError, "Too Big: The Canvas can only be a maximum of 250 by 250")
  end

  it "can't create a grid outside of its max size for y axis" do
    expect{described_class.new({y: Canvas::MAX_SIZE + 1, x: 1})}.to raise_error(CanvasError, "Too Big: The Canvas can only be a maximum of 250 by 250")
  end

  it "can create a negative canvas" do
    expect(described_class.new({x: -4, y: -3}).board).to eq([["O", "O", "O", "O"], ["O", "O", "O", "O"], ["O", "O", "O", "O"]])
  end

  it "fills a square within the boundaries " do
    subject.fill(0, 0, "W")
    expect(subject.board).to eq [["W","O", "O", "O"],["O","O", "O", "O"], ["O","O", "O", "O"]]
  end

  it "errors when outside the boundaries" do
    expect{subject.fill(5, 0, "W") }.to raise_error(CanvasError, "Out of boundaries: You are trying to paint off the canvas")
  end

  it "draws a vertical line" do
    subject.vertical_line(0, 1,  2, "W")
    expect(subject.board).to eq([["O","O", "O", "O"],["W","O", "O", "O"], ["W","O", "O", "O"]])
  end

  it "draws a horizontal line" do
    subject.horizontal_line(1,  2,  0, "W")
    expect(subject.board).to eq([["O","W", "W", "O"],["O","O", "O", "O"], ["O","O", "O", "O"]])
  end

  it "clears the board" do
    subject.fill(0,0,"W")
    subject.clear
    expect(subject.board).to eq [["O","O","O", "O"],["O","O", "O", "O"], ["O","O", "O", "O"]]
  end

  it "shows the board" do
    expect(STDOUT).to receive(:puts).with("[\"O\", \"O\", \"O\", \"O\"]").exactly(3).times
    subject.show
  end

  it "will fill all with white" do
    subject.fill_area(0, 0, "w")
    expect(subject.board).to eq  [["w","w","w","w"],["w","w", "w","w"], ["w","w","w","w"]]
  end

  it "will fill all with white apart from the black one" do
    subject.fill(0,0, "b")
    subject.fill_area(0, 1, "w")
    expect(subject.board).to eq  [["b","w", "w", "w"],["w","w", "w", "w"], ["w","w","w", "w"]]
  end

  it "will only fill the top line" do
    subject.horizontal_line('0', '3', '1', "b")
    subject.fill_area('0', '0', "w")
    expect(subject.board).to eq  [["w","w","w","w"],["b","b","b","b"], ["O","O","O","O"]]
  end

  # * V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
  # * H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
  it "will only fill the right section" do
    subject.vertical_line('1', '0', '2', "b")
    subject.fill_area('3', '2', "w")
    expect(subject.board).to eq  [["O","b","w","w"],["O","b","w","w"],["O","b","w","w"]]
  end

  # * R X1 X2 Y1 Y2 C - Draw a rectangle within boundaries.
  it "can create a rectangle" do
    subject.draw_rectangle(1, 3, 0, 2, "w")
    expect(subject.board).to eq ([["O","w", "w", "w"],
                                  ["O","w", "O", "w"],
                                  ["O","w", "w", "w"]])
  end

  # * R X1 X2 Y1 Y2 C - Draw a rectangle within boundaries.
  it "can create a rectangle regardless of points" do
    subject.draw_rectangle(3, 1, 2, 0, "w")
    expect(subject.board).to eq ([["O","w", "w", "w"],
                                  ["O","w", "O", "w"],
                                  ["O","w", "w", "w"]])
  end


end
