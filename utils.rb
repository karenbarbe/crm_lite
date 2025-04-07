require 'rainbow'

module Colors
  def self.primary(text)
    Rainbow(text).orangered
  end

  def self.secondary(text)
    Rainbow(text).indianred
  end
end

module Spacing
  def self.line(number)
    number.times { puts "\n"}
  end
end
