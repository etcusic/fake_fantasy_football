class PlayersController < ApplicationController

    get '/players' do
        @players = Player.all
        erb :"players/index"
    end
    
end