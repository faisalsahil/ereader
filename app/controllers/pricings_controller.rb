class PricingsController < ApplicationController

	def index
		if current_user && current_user.user_type=="admin"
			@pricings = Pricing.order("group_name ASC").page(params[:page]).per_page(5)

		else
			flash[:error] = "Please Login First."
       		redirect_to new_user_session_path	
		end	
	end


  def new
	if current_user && current_user.user_type=="admin"
		@apisetting = Apisetting.first
		if @apisetting.present?
			@mclist = Mclist.first
			if @mclist.present?
	            gb = Gibbon::API.new(@apisetting.api_key)
	            Gibbon::API.api_key = @apisetting.api_key
	            Gibbon::API.timeout = 15
	            Gibbon::API.throws_exceptions = false
	            @arr= []
	            @pricings= []
	            @list_groups = Gibbon::API.lists.interest_groupings(id: @mclist.list_id)
	            @list_groups.each do |obj,index|
	              if @mclist.grouping_id == obj["id"]
	                @grp = obj["groups"]
	                @grp.each do |grp|
	                   @arr << {name: grp["name"]} 
	                end
	              end
	            end
	            @count = @arr.count
	            @count.times { @pricings << @mclist.pricings.build }
	            if @arr[0] && @arr[0][:name].blank?
	              flash[:error] = "No group found against grouping selected by you."
	              redirect_to :back
	            end      
			else
				flash[:error]="Sorry! Please Select MC List First."
		    	redirect_to new_apisetting_path
			end
		else
			flash[:error]="Sorry! Please Enter Api Key First."
		    redirect_to new_apisetting_path
		end
	else
	   flash[:error] = "Please Login First."
       redirect_to new_user_session_path	
	end
  end

  def edit
  	@pricing = Pricing.find(params[:id])
  end

  def update
  	@pricing = Pricing.find(params[:id])
  	 if @pricing.update_attributes(params[:pricing])
  	   flash[:notice] = "Successfully update."
  	   redirect_to pricings_path
  	 else
  	 	flash[:error] = "Something went wrong."
  	 	redirec_to :back
  	 end
  end

  def destroy
  	@pricing = Pricing.find(params[:id])
   	@pricing.destroy
   	flash[:notice] = "Successfully destroy."
   	redirect_to pricings_path
  end
end
