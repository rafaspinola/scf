class ResultCenter < ActiveRecord::Base

	def to_s
		return self.name
	end
end
