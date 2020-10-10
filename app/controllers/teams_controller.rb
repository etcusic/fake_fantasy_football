class TeamsController < ApplicationController

    get '/teams' do
        #  binding.pry
        @users = User.all
        @teams = Team.all
        erb :"teams/index"
    end

    get '/teams/new' do
        #  binding.pry
        # user = User.find(session[:user_id])
        # if user.maximum_number_of_teams?
        #    redirect '/errors/ - max number of teams ' 
        @available_players = Player.all.select{|player| !player.team_id}
        if current_user.maximum_number_of_teams?
            redirect '/max_teams'
        else
            @available_teams = Team.all.select{|team| !team.user_id}
            erb :"teams/new"
        end
    end

    post '/teams/new' do
         binding.pry
        # CHECK IF NO TEAM WAS SUBMITTED
        # CHECK IF USER HAS MAX AMOUNT OF TEAMS!!!
        # CHECK IF TEAM NAME OR LOCATION IS SAME ANOTHER ONE
        @team = Team.find_by_id(params[:id])
        @team.update(
            user_id: current_user.id,
            slogan: params[:slogan]
        )
        players_array = [params[:qb], params[:rb], params[:wr], params[:te], params[:k]]
        assign_players_to_team(players_array, @team)
        redirect "/teams/#{ @team.id }"
    end

    get '/teams/new_from_scratch' do
        if current_user.maximum_number_of_teams?
            redirect '/max_teams'
        else
            @available_players = Player.all.select{|player| !player.team_id}
            erb :"teams/new_from_scratch"
        end
    end

    post '/teams/new_from_scratch' do
         
        # CHECK IF CORRECT AMOUNT OF PLAYERS/ATTRS SUBMITTED
        
        @team = Team.create(
            name: params[:name],
            location: params[:location],
            slogan: params[:slogan],
            logo: "/logos/your_logo_here.png",
            user_id: current_user.id
        )
        players_array = [params[:qb], params[:rb], params[:wr], params[:te], params[:k]]
        binding.pry
        if players_array.include?("invalid")
            redirect "/errors/team_error"
        else
            assign_players_to_team(players_array, @team)
        end
        redirect "/teams/#{ @team.id }"
    end

    get '/teams/:id' do
        @team = Team.find_by_id(params[:id])
        if @team.user_id == session[:user_id]
            erb :"teams/show"
        else
            erb :"nachos/nacho_team"
        end
    end

    get '/teams/:id/edit' do
        #  binding.pry
        @team = Team.find(params[:id])
        if @team.user_id != current_user.id
            erb :"nachos/nacho_stuff"
        else
            erb :"teams/edit"
        end
    end

    patch '/teams/:id' do
        binding.pry
        # VERIFY NAME AND LOCATION UPON SUBMISSION
        @team = Team.find(params[:id])
        if params[:delete_button]
            erb :"errors/delete_team"
        elsif @team
            @team.update(
                name: params[:name],
                location: params[:location],
                slogan: params[:slogan]
            )
            redirect "/teams/#{@team.id}"
        else
            erb :"errors/team_error"
        end
    end

    delete '/teams/:id' do
        @team = Team.find(params[:id])
        @team.delete
        redirect "/users/#{current_user.id}"
    end

end