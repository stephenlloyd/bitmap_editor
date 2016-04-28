require 'canvas'

describe Canvas do

  let(:subject){described_class.new({x: 3, y: 3})}

  it "creates a blank canvas" do
    expect(Canvas.new.board).to eq [['O']]
  end

  it "can't create a grid outside of its max size for x axis" do
    expect(lambda{Canvas.new({x: Canvas::MAX_SIZE + 1, y: 1})}).to raise_error("too big")
  end

  it "can't create a grid outside of its max size for x axis" do
    expect(lambda{Canvas.new({y: Canvas::MAX_SIZE + 1, x: 1})}).to raise_error("too big")
  end


  it "fills a square within the boundaries " do
    subject.fill(0, 0, "W")
    expect(subject.board).to eq [["W","O", "O"],["O","O", "O"], ["O","O", "O"]]
  end

  it "errors when outside the boundaries" do
    expect(lambda{ subject.fill(5, 0, "W") }).to raise_error("out of boundaries")
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
