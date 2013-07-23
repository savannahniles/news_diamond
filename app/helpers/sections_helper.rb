module SectionsHelper

	def capitalized_title(sentence)
  		stop_words = %w{a an and the or for of nor} 
  		sentence.split.each_with_index.map{|word, index| stop_words.include?(word) && index > 0 ? word : word.capitalize }.join(" ")
	end

end
