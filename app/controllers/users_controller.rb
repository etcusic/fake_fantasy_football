class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect "/users/#{session[:user_id]}"
        else
            erb :"users/signup"
        end
    end
    
    post '/users' do
        # CHECK FOR VALID INPUTS AND REDIRECT TO SIGNUP ERROR PAGE
        @user = User.new(params)
        if @user && @user.save
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            redirect '/signup_error'
        end
    end

    get '/users/:id' do     
            @user = User.find_by_id(params[:id])
            @user_teams = Team.all.select{|team| team.user_id == @user.id}
        # 2 different views for if user page doesn't match logged in user
        if not_users_stuff?   #params[:id].to_i == session[:user_id]  
            @not_user = User.find_by_id(session[:user_id])
            erb :"nachos/nacho_page"
        else
            erb :"users/show"
        end
    end

    get '/users/:id/edit' do
        if not_users_stuff?  
            erb :"nachos/nacho_stuff"
        else
            @user = User.find(params[:id])
            erb :"users/edit"
        end
    end

    patch "/users/:id" do
        # warn user of updating 
        binding.pry
        @user = User.find_by_id(params[:id])
        if @user.id && params[:edit_button] 
            @user.update(
                name: params[:name],
                username: params[:username],
                password: params[:password],
                photo_url: params[:photo_url],
                ssn: params[:ssn],
                credit_card_info: params[:credit_card_info],
                deepest_darkest_secret: params[:deepest_darkest_secret],
                what_you_want_for_christmas: params[:what_you_want_for_christmas]
            )
            redirect "/users/#{@user.id}"
        elsif params[:delete_button]
            redirect "/delete?"
        else
            redirect "/users/#{@user.id}"
        end
    end

    delete "/users/:id" do
        @user = User.find(params[:id])
        @user.delete
        redirect "/"
    end

end

