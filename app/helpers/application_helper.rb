module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "News Diamond"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def capitalized_title(sentence)
	  stop_words = %w{a an and the or for of nor} 
	  sentence.split.each_with_index.map{|word, index| stop_words.include?(word) && index > 0 ? word : word.capitalize }.join(" ")
  end

  def time_ago(time)
    time_local = time.localtime
    now = Time.now
    yesterday = now - (60*60*24)
    last_week = now - (60*60*24*7)
    if time_local.between?(yesterday, now)
      return time_local.strftime("Yesterday at %I:%M %p")
    elsif time_local.between?(last_week, now)
      return time_local.strftime("%A at %I:%M %p")
    else
      return time_local.strftime("%B %d at %I:%M %p")
    end
  end#time ago
  
end