class XmlrpcsController < ApplicationController

	def create
		if params[:xmlrpc][:path].present?
			@xmlrpc = Xmlrpc.new(params[:xmlrpc])
			@xmlrpc.save!
			flash[:notice] = "WordPress URL Successfully Submit."
			redirect_to new_apisetting_path
		else
			flash[:error] = "Please Enter WordPress URL."
			redirect_to :back
		end
	end

	def update
		if params[:xmlrpc][:path].present?
			@xmlrpc = Xmlrpc.find(params[:id])
			@xmlrpc.update_attributes(params[:xmlrpc])
    		flash[:notice] = "WordPress URL Successfully Update."
    		redirect_to new_apisetting_path
    	else
			flash[:error] = "Please Enter WordPress URL."
			redirect_to :back
		end
	end
end
