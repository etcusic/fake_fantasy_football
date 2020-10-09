require_relative 'sessions_controller.rb'

class SessionsController < ApplicationController

    get '/login' do
        if logged_in?
            redirect "/users/#{ session[:user_id] }"
        end
        erb :'sessions/login'
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else   
        # Need to develop errors for redirection
            redirect '/login_error'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end