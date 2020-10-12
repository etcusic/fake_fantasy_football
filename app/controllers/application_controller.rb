require './config/environment'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions, true  
    set :session_secret, ENV["SECRET"]  # environment variable 
  end

  get "/" do
    @landing_page = "Landing Page"
    erb :the_league
  end

  helpers do
    def logged_in?
      session[:user_id]
    end

    def current_user
      @user ||= User.find_by(id: session[:user_id])
    end

    def not_users_stuff?
      session[:user_id] != params[:id].to_i 
    end

    def redirect_if_not_logged_in
      if !logged_in?
        erb :the_league
      end
    end

    def redirect_if_logged_in
      if logged_in?
        redirect "/users/#{current_user.id}"
      end
    end

    def invalid?
      params.has_value?("invalid")
    end

    def assign_players_to_team(player_id_array, team)
      if player_id_array.include?("invalid")
        redirect "/invalid_team"
      else
        player_id_array.each{|id| Player.find_by_id(id).update(team_id: team.id)}
      end
    end

  end

end
