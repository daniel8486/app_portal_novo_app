class Pages::DashboardController < PagesController
  def index
  end

  def destroy
    params[:username] = nil
    params[:password] = nil
    reset_session
    redirect_to root_path  
    flash[:notice] = 'Agradecemos sua Visita!'   
  end

end
