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

    def same_name?
      !Team.find_by_name(params[:name])
    end

    def invalid_team?
      params[:name].strip == "" || params[:location].strip == "" || same_name?
    end

    def player_id_array
      array = [params[:qb], params[:rb], params[:wr], params[:te], params[:k]]
    end

    def assign_players_to_team(player_array, team)
      if player_array.include?("invalid")
        redirect "/invalid_team"
      else
        Player.all.where(team_id: @team.id).each{|p| p.update(team_id: nil)}
        player_array.each{|id| Player.find_by_id(id).update(team_id: team.id)}
      end
    end

  end

end
