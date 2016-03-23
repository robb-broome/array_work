class String
  def unshift
    self[0]
  end

  def rotate(num)
    rotation = num % self.length
    return self if rotation == 0
    self.class.new self[rotation..-1] + self[0..rotation -1]
  end

  def is_rotation_of?(other)
    return true if other == self
    self.length.times do |rotation|
      return true if other.rotate(rotation) == self
    end
    false
  end
end

def unique? str
  pos = -1
  loop do
    break unless char = str[pos += 1]
    check = pos
    loop do
      break unless check_char = str[check += 1]
      return false if char == check_char
    end
  end
  true
end
