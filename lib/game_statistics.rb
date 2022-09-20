require 'csv'
require 'pry'

module GameStatistics
  def highest_total_score
    highest_scoring_game = @games.max_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    highest_scoring_game[:away_goals].to_i + highest_scoring_game[:home_goals].to_i
  end

  def lowest_total_score
    lowest_scoring_game = @games.min_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    lowest_scoring_game[:away_goals].to_i + lowest_scoring_game[:home_goals].to_i
  end

  def percentage_home_wins
    home_wins = @games.count do |row|
      row[:away_goals] < row[:home_goals]
    end
    (home_wins.to_f / total_games).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |row|
      row[:away_goals] > row[:home_goals]
    end
    (visitor_wins.to_f / total_games).round(2)
  end

  def percentage_ties
    ties = @games.count do |row|
      [row[:away_goals]] == [row[:home_goals]]
    end
    (ties.to_f / total_games).round(2)
  end

  def count_of_games_by_season
    @games[:season].tally
  end

  def average_goals_per_game
    total_goals = @games[:away_goals].map(&:to_i).sum.to_f + @games[:home_goals].map(&:to_i).sum
    (total_goals / @games.size).round(2)
  end

  def average_goals_by_season
    season_goal_averages = Hash.new
    total_goals_per_season.each do |season, goals|
      season_goal_averages[season] = (goals / count_of_games_by_season[season]).round(2)
    end
    season_goal_averages
  end
end
