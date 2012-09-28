class String
  # Jaro distance
  def ^(other)
    return 0 if self.empty? or other.empty?
    s1 = self.codepoints.to_a
    s2 = other.codepoints.to_a
    s1, s2 = s2, s1 if s1.size > s2.size
    s1s, s2s = s1.size, s2.size

    m, t = 0.0, 0
    max_dist = s2s/2 - 1

    m1 = Array.new(s1s, nil)
    m2 = Array.new(s2s, false)

    # find m
    s1.each_with_index do |a, ia|
      lower = ia > max_dist ? ia-max_dist : 0
      upper = ia+max_dist < s2s ? ia+max_dist : s2s
      s2[lower..upper].each_with_index do |b, ib|
        ib += lower
        if a == b and !m2[ib]
          m, m1[ia], m2[ib] = m+1, ib, true
          break
        end
      end
    end
    
    m1.reduce do |a, b|
      # if either a or b are nil, that means there was no match
      # if a > b, that means the previous value is greater than the current
      # which means it went down
      if a != nil and b != nil and a > b
        t += (a-b > 1 ? 1 : 2)
      end
      b
    end

    dj = (m/s1s + m/s2s + (m - t/2)/m) / 3
    
    # winkler adjustment
    l = 0
    for i in 0..3
      s1[i] == s2[i] ? l += 1 : break
    end

    # standard weight (p) for winkler == 0.1
    dj + l*0.1*(1-dj)
  end
end
