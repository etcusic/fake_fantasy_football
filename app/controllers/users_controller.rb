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
        #  binding.pry
        # warn user of updating 
        button = params[:button]
        params.delete("button")
        params.delete("_method")
        # binding.pry
        if button == "edit" # params[:edit_button] 
            current_user.update(params)
            #     name: params[:name],
            #     username: params[:username],
            #     password: params[:password],
            #     photo_url: params[:photo_url],
            #     ssn: params[:ssn],
            #     credit_card_info: params[:credit_card_info],
            #     deepest_darkest_secret: params[:deepest_darkest_secret],
            #     what_you_want_for_christmas: params[:what_you_want_for_christmas]
            # )
            # binding.pry
            redirect "/users/#{current_user.id}"
        elsif button == "delete" # params[:delete_button]
            redirect "/delete?"
        else
            redirect "/users/#{current_user.id}"
        end
    end

    delete "/users/:id" do
        #  binding.pry
        @user = User.find(params[:id])
        @user.delete
        redirect "/"
    end

end

