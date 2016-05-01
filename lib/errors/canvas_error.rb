class CanvasError < StandardError

  def self.too_big(size)
    new("Too Big: The Canvas can only be a maximum of #{size} by #{size}")
  end

  def self.out_of_boundaries
    new("Out of boundaries: You are trying to paint off the canvas")
  end
end
