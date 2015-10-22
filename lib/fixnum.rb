class Fixnum
  def num_digits
    Math.log10(self).to_i + 1
  end
end
