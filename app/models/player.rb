class Player < ActiveRecord::Base

    belongs_to :team

    validates :name, :school, :position, presence: true
    validates :name, uniqueness: true
    
    def self.waivers
        self.all.select{| player | !player.team_id}
    end

    def available
        !self.team_id
    end
    
end