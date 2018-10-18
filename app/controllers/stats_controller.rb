class StatsController < ApplicationController
  def stats
    @numbers = params.fetch("list_of_numbers").gsub(",", "").split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum
    
    # we declare the default value of the median to be nil, we don't know what it is
    median = nil
    
    # if the number of observations is even
    if (@count % 2 == 0)
      # we need to find the middle 2 numbers
      left_index = @count / 2 - 1
      right_index = @count / 2
      median = (@sorted_numbers[left_index] + @sorted_numbers[right_index]) / 2
    else # if it's not odd, it's even
      median_index= (@count - 1) / 2 # recall the index starts at 0!
      median = @sorted_numbers[median_index]
    end

    @median = median

    @sum = @numbers.sum

    @mean = @sum / @count

    # create an empty array to hold square differences
    array_of_squared_diff = []
    
    @numbers.each do |num_1|
      # square the difference
      new_sq_diff = (num_1 - @mean) ** 2
      # add into array
      array_of_squared_diff.push(new_sq_diff)
    end
    
    # also convert into a float to avoid integer division
    sum_of_sq_diff = array_of_squared_diff.sum.to_f

    @variance = sum_of_sq_diff / @count

    @standard_deviation = Math.sqrt(@variance)

    max_count = 0
    mode = nil
    
    @numbers.each do |uniq_val|
      #counts number of times the uniq_val shows up in array
      new_max_count = @numbers.count(uniq_val)
      
      #if the maximum count of the currently evaluated value is greater than the previously stored max count, we update the max count and set the mode to be that value
      if max_count < new_max_count
        max_count = new_max_count
        mode = uniq_val
      end
    end

    @mode = mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("stats_templates/stats.html.erb")
  end

  def stats_form
    render("stats_templates/stats_form.html.erb")
  end
  
end
