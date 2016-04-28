require 'canvas'

describe Canvas do

  let(:subject){described_class.new({x: 3, y: 3})}

  it "creates a blank canvas with default colour" do
    expect(described_class.new.board).to eq [[Canvas::DEFAULT_COLOUR]]
  end

  it "can't create a grid outside of its max size for x axis" do
    expect{described_class.new({x: Canvas::MAX_SIZE + 1, y: 1})}.to raise_error(CanvasError, "Too Big: The Canvas can only be a maximum of 250 by 250")
  end

  it "can create a negative canvas" do
    expect(described_class.new({x: 3, y: 3}).board).to eq([["O", "O", "O"], ["O", "O", "O"], ["O", "O", "O"]])

  end

  it "can't create a grid outside of its max size for x axis" do
    expect{described_class.new({y: Canvas::MAX_SIZE + 1, x: 1})}.to raise_error(CanvasError, "Too Big: The Canvas can only be a maximum of 250 by 250")
  end

  it "fills a square within the boundaries " do
    subject.fill(0, 0, "W")
    expect(subject.board).to eq [["W","O", "O"],["O","O", "O"], ["O","O", "O"]]
  end

  it "errors when outside the boundaries" do
    expect{subject.fill(5, 0, "W") }.to raise_error(CanvasError, "Out of boundaries: You are trying to paint off the canvas")
  end

  it "draws a vertical line" do
    subject.vertical_line(0, 1,  2, "W")
    expect(subject.board).to eq([["O","O", "O"],["W","O", "O"], ["W","O", "O"]])
  end

  it "draws a horizontal line" do
    subject.horizontal_line( 0,  1,  2, "W")
    expect(subject.board).to eq([["O","W", "W"],["O","O", "O"], ["O","O", "O"]])
  end

  it "clears the board" do
    subject.fill( 0,0,"W")
    subject.clear
    expect(subject.board).to eq [["O","O", "O"],["O","O", "O"], ["O","O", "O"]]
  end

  it "shows the board" do
    expect(STDOUT).to receive(:puts).with("[\"O\", \"O\", \"O\"]").exactly(3).times
    subject.show
  end

end
