require_relative 'team'

class Leaderboard
GAME_INFO = [
    {
      home_team: "Patriots",
      away_team: "Broncos",
      home_score: 17,
      away_score: 13
    },
    {
      home_team: "Broncos",
      away_team: "Colts",
      home_score: 24,
      away_score: 7
    },
    {
      home_team: "Patriots",
      away_team: "Colts",
      home_score: 21,
      away_score: 17
    },
    {
      home_team: "Broncos",
      away_team: "Steelers",
      home_score: 11,
      away_score: 27
    },
    {
      home_team: "Steelers",
      away_team: "Patriots",
      home_score: 24,
      away_score: 31
    }
]

  attr_reader :teams, :game_info

  def initialize(game_info = GAME_INFO)
    @game_info = game_info
    @teams = []
  end

  def populate_teams
    @game_info.each do |game|
      team_home = @teams.find { |t| t.name == game[:home_team] }
      team_away = @teams.find { |t| t.name == game[:away_team] }

      if team_home.nil?
        team_home = Team.new(game[:home_team])
        @teams << team_home
      end

      if team_away.nil?
        team_away = Team.new(game[:away_team])
        @teams << team_away
      end
    end
    @teams
  end

  def records
    @teams.each do |team|
      @game_info.each do |game|
        if team.name == game[:home_team] && game[:home_score] > game[:away_score]
          team.wins += 1
        end
        if team.name == game[:home_team] && game[:home_score] < game[:away_score]
          team.losses += 1
        end
        if team.name == game[:away_team] && game[:away_score] > game[:home_score]
          team.wins += 1
        end
        if team.name == game[:away_team] && game[:away_score] < game[:home_score]
          team.losses += 1
        end
      end
    end
  end

  def record_sort
    @teams.sort_by! { |team| team.losses }
  end

  def team_rank
    num = 1
    @teams.each do |team|
      team.rank = num
      num += 1
    end
  end

  def summary
    leaderboard_string = "------------------------------------------------------\n"
    leaderboard_string += "|  Name\t\tRank\tTotal Wins\tTotal Losses |\n"
    @teams.each_with_index do |team, index|
      leaderboard_string += "|  #{team.name}\t#{team.rank}\t#{team.wins}\t\t#{team.losses}\t     |\n"
    end
    leaderboard_string += "------------------------------------------------------\n"
    leaderboard_string
  end

  def team_game_summary(team_name)
    num_games = 0
    game_summaries = ""
    game_overview = ""
    @teams.each do |team|
      if team.name == team_name
        @game_info.each do |game|
          if game[:home_team] == team_name || game[:away_team] == team_name
            num_games += 1

            if game[:home_team] == team_name && game[:home_score] > game[:away_score]
              game_summaries << "They played as the home team against the #{game[:away_team]} and won: #{game[:home_score]} to #{game[:away_score]}.\n"
            elsif game[:home_team] == team_name && game[:home_score] < game[:away_score]
              game_summaries << "They played as the home team against the #{game[:away_team]} and lost: #{game[:away_score]} to #{game[:home_score]}.\n"
            elsif game[:away_team] == team_name && game[:home_score] < game[:away_score]
              game_summaries << "They played as the away team against the #{game[:home_team]} and won: #{game[:away_score]} to #{game[:home_score]}.\n"
            elsif game[:away_team] == team_name && game[:home_score] > game[:away_score]
              game_summaries << "They played as the away team against the #{game[:home_team]} and lost: #{game[:home_score]} to #{game[:away_score]}.\n"
            end
            
          end
        end
        game_overview << "#{team_name} played #{num_games} games.\n"
        game_overview << game_summaries
      end
    end
    game_overview
  end
end

leaderboard = Leaderboard.new
leaderboard.populate_teams
leaderboard.records
leaderboard.record_sort
leaderboard.team_rank

puts leaderboard.summary

puts "==="

puts leaderboard.team_game_summary("Colts")
