module PricingsHelper
	def grouping1
		if controller.action_name == "index"
			@mclist = Mclist.first
			@grouping = @mclist.grouping_name
		end
	end
end
