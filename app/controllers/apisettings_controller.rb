class ApisettingsController < ApplicationController
  def new
    if current_user && current_user.user_type=="admin"
     
      @apisetting = Apisetting.first
      if @apisetting.blank?
         @apisetting = Apisetting.new
         @key_mandrill = KeyMandrill.first
         if !@key_mandrill.present?
            @key_mandrill = KeyMandrill.new
          else
            m = Mandrill::API.new(@key_mandrill.key)
            result = m.templates.list
            @list_template = []
            result.each_with_index do |template,index|
             @list_template << template["name"]
            end
         end
         @mandrill_setting = MandrillSetting.first
         if !@mandrill_setting.present?
           @mandrill_setting = MandrillSetting.new
         end
         @stripe = Stripeconnection.find_by_email(current_user.email)
         if !@stripe.present?
          @stripe = Stripeconnection.new         
         end

         # wordpress path
         @xmlrpc = Xmlrpc.first
         if !@xmlrpc.present?
            @xmlrpc = Xmlrpc.new
         end

         if params.present?
           @api_key = params[:api_key]
         end
      else
        redirect_to edit_apisetting_path(@apisetting)
      end
   else
     flash[:error] = "Please Login First."
       redirect_to new_user_session_path
   end
  end

  def create
    if params[:apisetting][:api_key].present?
      @api_key = params[:apisetting][:api_key]
      gb = Gibbon::API.new(@api_key)
      Gibbon::API.api_key = @api_key
      Gibbon::API.timeout = 15
      Gibbon::API.throws_exceptions = false

      # ------------load lists--------------

      @lists = Gibbon::API.lists.list
      if @lists["status"] != "error"
              @apisetting = Apisetting.first
              if @apisetting.present?
                @apisetting.update_attributes!(params[:apisetting])
                redirect_to new_apisetting_path, :notice=>"Mailchimp Api Key Successfully Created."
              else
                @apisetting = Apisetting.new(params[:apisetting])
                @apisetting.save!
                redirect_to new_apisetting_path, :notice=>"Mailchimp Api Key Successfully Updated."
              end
      else
        flash[:error]= "Your Api key Is Invalid."
        redirect_to :back
      end
    else
      flash[:error]= "Please Enter Mailchimp Api Key."
      redirect_to :back
    end
  end

  def edit
    if current_user && current_user.user_type=="admin"
          @apisetting = Apisetting.find(params[:id])
          @api_key = @apisetting.api_key
          @key_mandrill = KeyMandrill.first
          if !@key_mandrill.present?
            @key_mandrill = KeyMandrill.new
          else
            m = Mandrill::API.new(@key_mandrill.key)
            result = m.templates.list
            @list_template = []
            result.each_with_index do |template,index|
              @list_template << template["name"] 
            end
          end
          
          @mandrill_setting = MandrillSetting.first
          if !@mandrill_setting.present?
            @mandrill_setting = MandrillSetting.new
          end

          
          # stripe record retrieve
         @stripe = Stripeconnection.find_by_email(current_user.email)
         if !@stripe.present?
          @stripe = Stripeconnection.new         
         end

         # wordpress path
         @xmlrpc = Xmlrpc.first
         if !@xmlrpc.present?
            @xmlrpc = Xmlrpc.new
         end

         # list and grouping =====================================
        @mclist = Mclist.first
        if !@mclist.present?
          @mclist = Mclist.new
        # else
          # response1 = load_groups(@mclist,@apisetting)
        end
        if params[:groups].present?
          @groups = params[:groups]
        end

        if params[:listid].present?
          @mclist.list_id = params[:listid]
        end
        response = fetch_list(@api_key)
        if response != false
          @listloaded  = response
        end
# ==================================================

    else
      flash[:error] = "Please Login First."
      redirect_to new_user_session_path
    end
  end

def load_groups
    # @mclist = Mclist.find_by_list_id(params[:mclist])   # Today Changes
    # @mclist = mclist
    # puts "-------------------------------------------------------------------------------------------------------
    # ====================================================------"
    @listid = params[:key]
    @apisetting = Apisetting.first
    gb = Gibbon::API.new(@apisetting.api_key)
    Gibbon::API.api_key = @apisetting.api_key
    Gibbon::API.timeout = 15
    Gibbon::API.throws_exceptions = false
            # ------------load lists--------------
    @arr= []
    @pricings= []
    # begin
     @list_groups = Gibbon::API.lists.interest_groupings(id: @listid)
    #  rescue Exception => e 
    #   puts 
    #   puts
    #   puts e.inspect
    # end
    @list_groups.each do |obj,index|
      @arr << {id: obj["id"], name: obj["name"]}
    end
    # @count = @arr.count
    # puts @list_groups
    # @count.times { @pricings << @mclist.pricings.build }
    if @arr[0] && @arr[0][:id].blank?
      flash[:error] = "No group found against list selected by you."
      redirect_to :back
    else
      redirect_to edit_apisetting_path(@apisetting, :groups=>@arr, :listid=>@listid)
    end
end

def update
     @api_key = params[:apisetting][:api_key]
      gb = Gibbon::API.new(@api_key)
      Gibbon::API.api_key = @api_key
      Gibbon::API.timeout = 15
      Gibbon::API.throws_exceptions = false
      @lists = Gibbon::API.lists.list
      if @lists["status"] != "error"
        @apisetting = Apisetting.find(params[:id])
          @apisetting.update_attributes!(params[:apisetting])
          redirect_to new_apisetting_path, :notice=>"Mandrill Api Key Successfully Created."
      else
        flash[:error]= "Your Api key Is Invalid."
        redirect_to :back
      end
end

def stripe_request
    
    @code = params[:code]
    response = HTTParty.post(
                    "https://connect.stripe.com/oauth/token?client_secret=sk_test_cWbI1fA0O5evvorlsXuD4C23&code="+ @code + "&grant_type=authorization_code"
                              )
     @stripe = Stripeconnection.new
     @stripe.email = current_user.email
     @stripe.access_token = response["access_token"]
     @stripe.ref_token  = response["refresh_token"]
     @stripe.token_type  = response["token_type"]
     @stripe.stripe_user_id  = response["stripe_user_id"]
     @stripe.save
     redirect_to new_apisetting_path
end



def fetch_list(key)
     
      gb = Gibbon::API.new(key)
        Gibbon::API.api_key = key
        Gibbon::API.timeout = 15
        Gibbon::API.throws_exceptions = false

        # ------------load lists--------------
        @lists = Gibbon::API.lists.list
        if @lists["status"] == "error"
            flash[:error]="Sorry! Please Enter Correct Api Key."
            return false
        else
            @listloaded = []
            @lists['data'].each_with_index do |list, index|
              @listloaded[index] = {}
              @listloaded[index]["id"] = list["id"]
              @listloaded[index]["name"] = list["name"]
            end
            return @listloaded
        end
end

end
