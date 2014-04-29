module RatingAverage
	extend ActiveSupport::Concern

	def average_rating
	   

		user_tanks.average :rating


	end
	


end
