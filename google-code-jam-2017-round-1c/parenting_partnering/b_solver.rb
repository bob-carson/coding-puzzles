class BSolver
  DAY_END = 1440
  MAX_TIME = 720

  CAM = "c"
  JAM = "j"

  def solve(cam, jam)
    timeline = []

    cam_remaining = MAX_TIME - cam.inject(0) { |sum, c| sum + (c[1] - c[0]) }
    jam_remaining = MAX_TIME - jam.inject(0) { |sum, j| sum + (j[1] - j[0]) }

    cam.each { |c| timeline << [*c, CAM] }
    jam.each { |j| timeline << [*j, JAM] }

    timeline.sort_by! { |t| t[0] }

    c_gaps = []
    j_gaps = []
    exchange_gaps = []
    timeline.each_with_index do |t, index|
      this_person = t[2]
      if index == timeline.count - 1
        next_event = timeline[0]
      else
        next_event = timeline[index + 1]
      end
      next_person = next_event[2]

      if this_person == next_person
        if this_person == CAM
          c_gaps << [t[1], next_event[0], _time_between(t[1], next_event[0])]
        else
          j_gaps << [t[1], next_event[0], _time_between(t[1], next_event[0])]
        end
      else
        exchange_gaps << [t[1], next_event[0], _time_between(t[1], next_event[0])]
      end
    end

    c_gaps.select! { |c| c[2] > 0 }
    j_gaps.select! { |c| c[2] > 0 }

    c_gaps.sort_by! { |t| t[2] }
    j_gaps.sort_by! { |t| t[2] }

    while c_gaps.count > 0
      break if cam_remaining < c_gaps[0][2]

      gap = c_gaps.shift
      cam_remaining -= gap[2]
    end

    while j_gaps.count > 0
      break if jam_remaining < j_gaps[0][2]

      gap = j_gaps.shift
      jam_remaining -= gap[2]
    end

    # puts "c gaps #{c_gaps}"
    # puts "c remaining #{cam_remaining}"
    # puts "j gaps #{j_gaps}"
    # puts "j remaining #{jam_remaining}"
    # puts "exchange #{exchange_gaps}"

    2 * (c_gaps.count + j_gaps.count) + exchange_gaps.count
  end

  def _time_between(start, finish)
    answer = finish - start

    answer >= 0 ? answer : answer + DAY_END
  end
end
