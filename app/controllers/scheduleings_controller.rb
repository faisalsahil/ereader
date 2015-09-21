class ScheduleingsController < ApplicationController

	def index
		require 'american_date'
		puts params[:start_date]
		start_date = params[:start_date].to_date.strftime('%Y-%m-%d')
		# start_date = params[:start_date].to_date.parse('%Y-%d-%m')
		puts start_date
		puts
		puts
		puts
		puts params[:end_date]
		end_date = params[:end_date].to_date.strftime('%Y-%m-%d')
		puts end_date
		if current_user && current_user.user_type=="admin"
			 @author_books =AuthorBook.where(:status => "approved")
			 @scheduleings = Scheduleing.where('scheduleings.schedule_date >= ? AND scheduleings.schedule_date <= ?', start_date, end_date)
		else
       		 flash[:error] = "Please Login First."
       	 	redirect_to new_user_session_path
        end 
	end

	def new
		if current_user && current_user.user_type=="admin"
			@author_book = AuthorBook.find_by_id(params[:author_book_id])
			@schedule = @author_book.build_scheduleing
		else
       		 flash[:error] = "Please Login First."
       		 redirect_to new_user_session_path
     	end
	end

	def create
		@author = AuthorBook.find_by_id(params[:author_book_id])
		@schedule = @author.build_scheduleing(params[:scheduleing])
		@schedule.save!
		flash[:notice] = "Book Successfully Schedule"
		redirect_to author_books_path
	end

	def edit
		if current_user && current_user.user_type=="admin"
			@author_book = AuthorBook.find_by_id(params[:author_book_id])
			@schedule = @author_book.scheduleing
		else
      		flash[:error] = "Please Login First."
     	    redirect_to new_user_session_path
      	end
	end

	def update
		@author_book = AuthorBook.find_by_id(params[:author_book_id])
		@schedule = @author_book.scheduleing
		puts @schedule

		@schedule.update_attributes(params[:scheduleing])
		flash[:notice] = "Schedule date Successfully updated."
		redirect_to schedule_range_scheduleings_path
	end
	
	def report
		puts params[:start_date]
		start_date = params[:start_date].to_date.strftime('%Y-%m-%d')
		# start_date = params[:start_date].to_date.parse('%Y-%d-%m')
		puts start_date
		puts
		puts
		puts
		puts params[:end_date]
		end_date = params[:end_date].to_date.strftime('%Y-%m-%d')
		if current_user && current_user.user_type=="admin"
			 @author_books =AuthorBook.where(:status => "approved")
			 @scheduleings = Scheduleing.where('scheduleings.schedule_date >= ? AND scheduleings.schedule_date <= ?', start_date, end_date)
		else
       		 flash[:error] = "Please Login First."
       	 	redirect_to new_user_session_path
        end 
	end

	def schedule_range
		# something doing here
	end

	def report_range
		# something doing here
	end
end
