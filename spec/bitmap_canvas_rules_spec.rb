require 'bitmap_canvas_rules'
describe BitmapCanvasRules do
  let(:canvas){double(:canvas)}
  let(:canvas_klass){double(:canvas_klass, new: canvas)}
  let(:subject){described_class.new(canvas: canvas_klass)}

  it("creates a new canvas") do
    expect(canvas_klass).to receive(:new).with({x: "5", y: "5"})
    subject.process("I 5 5")
  end

  it("askes you build a canvas if you haven't already") do
      expect(STDOUT).to receive(:puts).with "You must create a canvas first, try \"I 5 5\""
      subject.process("C")
  end

  context "when a board is created" do

    before{subject.process("I 5 5")}

    it ("can clear") do
      expect(canvas).to receive(:clear).with no_args
      subject.process("C")
    end

    it("Fill a single pixel") do
      expect(canvas).to receive(:fill).with("1", "2", "W")
      subject.process("L 1 2 W")
    end

    it("Fill a vertical line") do
      expect(canvas).to receive(:vertical_line).with("O",  "1", "2", "W")
      subject.process("V O 1 2 W")
    end

    it("Fill a horizontal line") do
      expect(canvas).to receive(:horizontal_line).with("O",  "1", "2", "W")
      subject.process("H O 1 2 W")
    end

    it("Show the canvas") do
      expect(canvas).to receive(:show).with no_args
      subject.process("S")
    end
  end
end
