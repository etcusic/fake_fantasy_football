class User < ActiveRecord::Base
    
    has_secure_password

    validates :username, :password, presence: true
    validates :username, uniqueness: true
    
    has_many :teams 
    # has_many :players, through: :team
    
    def maximum_number_of_teams?
        user_teams = Team.all.select{|team| team.user_id == self.id}
        user_teams.length >= 3
    end

    # def all_teams
    #     Team.all.select{|team| team.user_id == self.id}
    # end

    # def all_players
        
    # end
end