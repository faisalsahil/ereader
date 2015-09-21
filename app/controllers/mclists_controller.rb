class MclistsController < ApplicationController

	def create
  	if current_user && current_user.user_type=="admin"
  		if params[:mclist][:list_id].present? && params[:mclist][:grouping_id].present?
  			@apisetting = Apisetting.first
         # @mclist = Mclist.find_by_list_id(params[:mclist][:list_id])    #today  changes 
         response_group_name = search_group_name(params[:mclist][:list_id],params[:mclist][:grouping_id],@apisetting.api_key)
         response_list_name = search_list_name(params[:mclist][:list_id],@apisetting.api_key)
         @mclist = Mclist.first
         if !@mclist.present?
  			   @mclist = Mclist.new(params[:mclist])
           @mclist.key = @apisetting.api_key
           @mclist.email = current_user.email
           @mclist.list_name = response_list_name
           @mclist.grouping_name = response_group_name
           @mclist.save! 
          else
            @mclist.key = @apisetting.api_key
            @mclist.email = current_user.email
            @mclist.list_name = response_list_name
            @mclist.grouping_name = response_group_name
            @mclist.update_attributes!(params[:mclist])
          end
        # redirect_to load_groups_mclists_path(:mclist=> params[:mclist][:list_id] )
        redirect_to edit_apisetting_path(@apisetting)
  		else
	      flash[:error]= "Please Select Mailchimp List And Grouping."
	      redirect_to :back
	    end
  	else
     flash[:error] = "Please Login First."
       redirect_to new_user_session_path
   end
  end

  def search_list_name(listid,apikey)
    gb = Gibbon::API.new(apikey)
    Gibbon::API.api_key = apikey
    Gibbon::API.timeout = 15
    Gibbon::API.throws_exceptions = false
            # ------------load lists--------------
    @list_name = ''
    @lists = Gibbon::API.lists.list
    @lists['data'].each_with_index do |list, index|
      if listid == list["id"]
        @list_name = list["name"]
      end
    end
    return @list_name
  end

  def search_group_name(listid,groupingid,apikey)  
    gb = Gibbon::API.new(apikey)
    Gibbon::API.api_key = apikey
    Gibbon::API.timeout = 15
    Gibbon::API.throws_exceptions = false
    @arr = ''
    @pricings= []
    @list_groups = Gibbon::API.lists.interest_groupings(id: listid)
    @list_groups.each_with_index do |obj,index|
      if groupingid.to_f ==  obj["id"]
        @arr = obj["name"]
      end
    end
      return @arr
  end

  def update
    @mclist = Mclist.find(params[:id])
    @mclist.update_attributes(params[:mclist])
    flash[:notice] = "Pricing successfully create.."
    redirect_to pricings_path
  end

  # fild all group against one grouping
  def load_group1
    @mclist = Mclist.find(params[:id])
    @mclist.grouping_id = params[:grouping_name]
    @mclist.update_attributes(params[:mclist])
    # =================  Retrieve Groups ==========================
            @listid = @mclist.list_id
            @grpid = @mclist.grouping_id
            @apisetting = Apisetting.first
            gb = Gibbon::API.new(@apisetting.api_key)
            Gibbon::API.api_key = @apisetting.api_key
            Gibbon::API.timeout = 15
            Gibbon::API.throws_exceptions = false

            @arr= []
            @pricings= []
             @list_groups = Gibbon::API.lists.interest_groupings(id: @listid)
            @list_groups.each do |obj,index|
              if @grpid == obj["id"]
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
  end

  def modify_list
    if current_user && current_user.user_type == "admin"
      @mclist = Mclist.first
      @mclist.destroy
      Pricing.destroy_all
      redirect_to new_apisetting_path
    else
      flash[:error] = "Please Login First."
      redirect_to new_user_session_path
    end
  end
end

