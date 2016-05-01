require 'errors/canvas_error'

describe CanvasError do
  it("can raise a too big error") do
    expect(described_class.too_big(250).message).to eq "Too Big: The Canvas can only be a maximum of 250 by 250"
  end

  it("can raise an out of boundaries error") do
    expect(described_class.out_of_boundaries.message).to eq "Out of boundaries: You are trying to paint off the canvas"
  end

end
