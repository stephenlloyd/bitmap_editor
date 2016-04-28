class CanvasError < StandardError

  def self.too_big
    new("Too Big: The Canvas can only be a maximum of 250 by 250")
  end

  def self.out_of_boundaries
    new("Out of boundaries: You are trying to paint off the canvas")
  end
end
