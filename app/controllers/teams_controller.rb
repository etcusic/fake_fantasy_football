class TeamsController < ApplicationController

    get '/teams' do
        @users = User.all
        @teams = Team.all
        erb :"teams/index"
    end

    get '/teams/new' do
        # user = User.find(session[:user_id])
        # if user.maximum_number_of_teams?
        #    redirect '/errors/ - max number of teams ' 

        if current_user.maximum_number_of_teams?
            redirect '/max_teams'
        else
            @available_teams = Team.all.select{|team| !team.user_id}
            erb :"teams/new"
        end
    end

    post '/teams/new' do
        # CHECK IF NO TEAM WAS SUBMITTED
        # CHECK IF USER HAS MAX AMOUNT OF TEAMS!!!
        @team = Team.find_by_id(params[:id])
        @team.user_id = current_user.id
        @team.location = params[:location]
        @team.slogan = params[:slogan]
        @team.save
        # erb :"players/add_players"
        redirect "/teams/#{ @team.id }"
    end

    get '/teams/new_from_scratch' do
        if current_user.maximum_number_of_teams?
            redirect '/max_teams'
        else
            erb :"teams/new_from_scratch"
        end
    end

    post '/teams/new_from_scratch' do
        # CHECK IF NO TEAM WAS SUBMITTED
        # CHECK IF PLAYER HAS MAX AMOUNT OF TEAMS!!!
        @team = Team.create(params)
        @team.user_id = current_user.id
        @team.save
        # erb :"players/add_players"
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
        @team = Team.find(params[:id])
        if @team.user_id != current_user.id
            erb :"nachos/nacho_stuff"
        else
            erb :"teams/edit"
        end
    end

    patch '/teams/:id' do
        @team = Team.find(params[:id])
        #needs verification!
        if @team
            @team.update(
                name: params[:name],
                location: params[:location],
                slogan: params[:slogan]
            )
            redirect "/teams/#{@team.id}"
        # error redirection needs to be worked out    
        # else
        #     erb :"errors/"
        end
    end

    delete '/teams/:id' do
        # @team = Team.find(params[:id])
        # @user = User.find(@team.user_id)
        # @team.delete
        # redirect "/users/#{@user.id}"
    end

end