require 'canvas'

describe Canvas do

  let(:subject){described_class.new({x: 2, y: 2})}

  it "creates a blank canvas" do
    expect(Canvas.new.board).to eq [['O']]
  end

  context "#fill" do
    it "a square within the boundaries " do
      subject.fill({x: 0, y: 0, colour: "W"})
      expect(subject.board).to eq [["W","O"],["O","O"]]
    end

    it "errors when outside the boundaries" do
      expect(lambda{ subject.fill({x: 5, y: 0, colour: "W"}) }).to raise_error("out of boundaries") 
    end
  end

end
