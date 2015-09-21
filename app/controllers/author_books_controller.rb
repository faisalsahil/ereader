class AuthorBooksController < ApplicationController

def index
  puts params
  if current_user && current_user.user_type=="admin"
    @author_books =AuthorBook.where(:status => "pending").order("genres ASC")
    @key_mandrill = KeyMandrill.first
    if @key_mandrill.present?
      m = Mandrill::API.new(@key_mandrill.key)
      result = m.templates.list
      @list_template = []
      result.each_with_index do |template,index|
       @list_template << template["name"]
      end
    end  
  else
    flash[:error] = "Please Login First."
    redirect_to new_user_session_path
  end   
end

def new
 	@author_book = AuthorBook.new
  @payment = @author_book.build_payment
  @ret = GENRES_CONSTANT::Links_RETAILORS
  @count = @ret.count
  @retailer = @count.times{@author_book.retailers.build} 
  if params[:error].present?
    @error = params[:error]
  end 
  # @retailers = @alayoutsuthor_book.retailers.build
  render layout: "dashboard"
end

def create
  # @date = Date.today
  # puts "============================================"
  # puts @date
 	@author_book = AuthorBook.new(params[:author_book])
  @author_book.status = "pending"
  @author_book.payment_status = "None"
  # @author_book.preferred_start_date = @date
  # @author_book.preferred_end_date = @date
  if @author_book.save
    @genres_price = Pricing.find_by_group_name(@author_book.genres)
    @pb_price = @author_book.pb_price.to_f
    if @pb_price == 0.00
        @price = @genres_price.tier_1
    elsif @pb_price >= 0.01 && @pb_price <= 2.98
        @price = @genres_price.tier_2
    elsif @pb_price >= 2.99
        @price = @genres_price.tier_3
    end
    @author_book.genre_price = @price
    @author_book.save!
    flash[:notice] = "Thank you for submission.  We will contact you to let you know whether or not we will be promoting your book."
    redirect_to new_author_book_path()
  else
    @ret = GENRES_CONSTANT::Links_RETAILORS
    @count = @ret.count
    @retailer = @count.times{AuthorBook.new.retailers.build}
    flash[:error] = "Please Fill All Fields."
    render :new
    # render "new"
  end
end

def show
  if current_user && current_user.user_type=="admin"
    @author_book = AuthorBook.find(params[:id])
    respond_to do |format|
        format.js # actually means: if the client ask for js -> return file.js
    end
  else
        flash[:error] = "Please Login First."
        redirect_to new_user_session_path
  end   
end
  # =================  author book approve here   ============================
def update
  if current_user && current_user.user_type=="admin"
    @author_book = AuthorBook.find(params[:id])
    @email = @author_book.email
    @template = MandrillSetting.first.apr_tempate
    @key = KeyMandrill.first
    m = Mandrill::API.new(@key.key)
    book_name = @author_book.title
    promotional_price = @author_book.pb_price
    preferred_start_date = @author_book.scheduleing.schedule_date
    promot_cost = @author_book.genre_price
    @url = "#{request.protocol}#{request.host}/author_books/#{@author_book.id}/payments/new"
    @mandrill = MandrillSetting.first
    if @mandrill.present?
      rendered = m.templates.render "#{@template}",[{:name => "book-name", :content => book_name},
                                             {:name => "promotopnal-price", :content => promotional_price},
                                             {:name => "preferred-date", :content => preferred_start_date},
                                             {:name => "promo-cost", :content => promot_cost},
                                             {:name => "payment_link", :content => "#{@url}"}
                                           ]
      message = {
                :subject=> "#{@mandrill.apr_subject || "Your Request Successfully Approved"} with Preferred date #{@author_book.preferred_start_date}",
                :from_name=> @mandrill.from_name,
                :from_email=> @mandrill.from_email,
                :to=>[{:email=> @email,:name =>  @author_book.name}],
                :html=>rendered['html']
                  }
      sending = m.messages.send message
      if sending[0] && sending[0]["status"] == "sent"
          @author_book.status = "approved"
          @author_book.payment_status = "unPaid"
          @author_book.save!
          flash[:notice] = "Successfully Approved."
          redirect_to author_books_path
      end
    else
      flash[:error] ="Please enter mandrill settings first."
      redirect_to new_apisetting_path
    end
  else
    flash[:error] = "Please Login First."
   redirect_to new_user_session_path
 end
end
 
def reject_status
  if current_user && current_user.user_type=="admin" 
    if params[:author_book][:template].present?
      @template = params[:author_book][:template]
      @author_book = AuthorBook.find(params[:id])
      @author_book.status = "rejected"
      @author_book.template = @template
      @author_book.save!
      @email = @author_book.email
      # ======================= mandrill template  ===========================
      # @template = MandrillSetting.first.rem_template
      @mandrill = MandrillSetting.first
      @key = KeyMandrill.first
      m = Mandrill::API.new(@key.key)
      if @mandrill.present?
         book_name = @author_book.title
         promotional_price = @author_book.pb_price
         preferred_date = @author_book.preferred_start_date
         rendered = m.templates.render "#{@template}",[]
         message = {
                        :subject=> @mandrill.rem_subject,
                        :from_name=> @mandrill.from_name,
                        :from_email=> @mandrill.from_email,
                        :to=>[{:email=> @email,:name =>  @author_book.name}],
                        :html=>rendered['html']
                    }
            sending = m.messages.send message
            if sending[0] && sending[0]["status"] == "sent"
              redirect_to author_books_path, :notice=>"Successfully Rejected."
            else
              flash[:error] = "Something wen wrong."
              redirect_to author_books_path
            end
      else
        flash[:error] ="Please enter mandrill settings first."
        redirect_to new_apisetting_path
      end
    else
      flash[:error] = "Please select template."
      redirect_to :back
    end
  else
    flash[:error] = "Please Login First."
    redirect_to new_user_session_path
  end
end

def edit
  if current_user && current_user.user_type=="admin"
    @author_book = AuthorBook.find(params[:id])
  else
    flash[:error] = "Please Login First."
    redirect_to new_user_session_path
  end
end

def update_status
  if current_user && current_user.user_type=="admin"
      @author_book = AuthorBook.find(params[:id])
      @author_book.payment_status = params[:author_book][:payment_status]
      if @author_book.save
        flash[:notice] = "Payment Status Successfully update."
        redirect_to schedule_range_scheduleings_path
      else
        flash[:error] = "Something Wrong."
        redirect_to :back
      end
  else
    flash[:error] = "Please Login First."
    redirect_to new_user_session_path
  end
end

def edit_date
  if current_user && current_user.user_type=="admin"
      @author_book = AuthorBook.find(params[:id])
  else
    flash[:error] = "Please Login First."
    redirect_to new_user_session_path
  end
end

def update_date
  if current_user && current_user.user_type=="admin"
    @author_book = AuthorBook.find(params[:id])
    @author_book.update_attributes!(params[:author_book])
    flash[:notice] = "Preferred date successfully update."
    redirect_to author_books_path
  else
    flash[:error] = "Please Login First."
    redirect_to new_user_session_path
  end
end


def aaa
  @token = base64_encode(openssl_random_pseudo_bytes(32))
  # puts "================================================================================"
  # puts @token
end

def bbb
end
end


