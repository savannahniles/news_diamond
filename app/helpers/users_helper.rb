module UsersHelper
  
  # Returns the current time formatted nicely
  def current_time
    time = Time.new
    return time.strftime("%A, %B %d, %Y")
  end
end
