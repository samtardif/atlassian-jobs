class SitesController < ApplicationController
  def show
    case params[:name]
    when 'github'
      render :json => Github.get_stats(params[:username])
    when 'bitbucket'
      render :json => Bitbucket.get_stats(params[:username])
    when 'dribbble'
      render :json => Dribbble.get_stats(params[:username])
    else
      render :text => ""
    end
  end
end
