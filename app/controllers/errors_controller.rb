class ErrorsController < ApplicationController

    get '/nacho_stuff' do
        # include @user to add link to user's homepage after message
        erb :'nashos/cleaver'
    end

    get '/login_error' do
        erb :'errors/login_error'
    end

    get '/signup_error' do
        erb :'errors/signup_error'
    end

    get '/delete?' do
        @user = current_user
        erb :'errors/delete_profile'
    end

    get '/max_teams' do 
        @user = current_user
        erb :'errors/max_teams'
    end

    get '/new_team_error' do
        @user = current_user
        erb :'new_team_error'
    end

    get '/invalid_team' do
        @user = current_user
        erb :'errors/invalid_team'
    end

    get '/edit_profile_error' do
        @user = current_user
        erb :'errors/edit_profile_error'
    end

end