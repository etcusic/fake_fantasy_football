class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect "/users/#{session[:user_id]}"
        else
            erb :"users/signup"
        end
    end
    
    post '/users' do
        @user = User.new(params)
        if params[:name] == "" || params[:username] == "" || params[:password] == ""
            redirect '/signup_error'       
        elsif @user && @user.save   
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            redirect '/signup_error'
        end
    end

    get '/users/:id' do    
        @user = User.find_by_id(params[:id])
        if params[:id].to_i == session[:user_id]  
            erb :"users/show"
        else
            @not_user = User.find_by_id(session[:user_id])
            erb :"nachos/nacho_page"
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
        button = params[:button]
        params.delete("button")
        params.delete("_method")
        # binding.pry
        # STILL HAVING AN ISSUE WITH #UPDATE RETURN FALSE
        if button == "EDIT" && current_user.update(params)
            redirect "/users/#{current_user.id}"
        elsif button == "DELETE" 
            redirect "/delete?"
        else
            redirect "/edit_profile_error"
        end
    end

    delete "/users/:id" do
        @user = User.find(params[:id])
        @user.delete
        redirect "/"
    end

end

