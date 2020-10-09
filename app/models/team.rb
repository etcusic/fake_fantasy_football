class Team < ActiveRecord::Base
    
    belongs_to :user
    has_many :players

    validates :name, presence: true
    
    def self.under_capacity?
        self.all.count <= 12
    end

    def self.roster_construction
        # maximum number of players from each position allowed on a team
        roster = {
            "QB" => 1,
            "RB" => 2,
            "WR" => 2,
            "K" => 1
        }
    end

    # Does this belong here??
    def self.roster_setup
        roster = ["QB", "RB", "RB", "WR", "WR", "K"]
    end

    def roster_array
        roster = Player.all.select{|player| player.team_id == self.id}
    end

    def owner
        User.all.select{| user | user.id == self.user_id } [0]
    end
end

# teams = Team.all
# teams.each do |team|
#     if team.user_id
#         qb = Player.all.detect{|player| !player.team_id && player.position == "QB"} [0]
#         kicker = Player.all.detect{|player| !player.team_id && player.position == "K"} [0]
#         rb = Player.all.select{|player| !player.team_id && player.position == "RB"} 
#         wr = Player.all.select{|player| !player.team_id && player.position == "WR"} 
#         qb.update(team_id = self.id)
#         rb[0].update(team_id = self.id)
#         rb[1].update(team_id = self.id)
#         wr[0].update(team_id = self.id)
#         wr[1].update(team_id = self.id)
#         kicker.update(team_id = self.id)
#     end
# end