class ErrorsController < ApplicationController

    get '/errors/nacho_stuff' do
        erb :'nachos/nacho_stuff'
    end

    get '/errors/login' do
        erb :'errors/login'
    end

    get '/errors/signup' do
        erb :'errors/signup'
    end

    get '/errors/delete?' do
        @user = current_user
        erb :'errors/delete_profile'
    end

    get '/errors/max_teams' do 
        @user = current_user
        erb :'errors/max_teams'
    end

    get '/errors/invalid_team' do
        @user = current_user
        erb :'errors/invalid_team'
    end

    get '/errors/edit_profile' do
        @user = current_user
        erb :'errors/edit_profile'
    end

end