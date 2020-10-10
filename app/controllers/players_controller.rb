class PlayersController < ApplicationController

    get '/players' do
        @players = Player.all
        erb :"players/index"
    end

    get '/teams/:id/add_and_drop' do
        # binding.pry
        @team = Team.find_by_user_id(current_user.id)
        @qbs = Player.all.select{|p| p.position == "QB"}
        @kickers = Player.all.select{|p| p.position == "K"}
        @rbs = Player.all.select{|p| p.position == "RB"}
        @wrs = Player.all.select{|p| p.position == "WR"}
        erb :'/players/add_and_drop'
    end

    post '/players/add_and_drop' do
        # binding.pry

        # redirect "/teams/#{@team.id}"
    end
    
end