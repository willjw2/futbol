require 'csv'

module LeagueStatistics
  def count_of_teams
    @teams.length
  end

  def best_offense
    team_goals_per_game = avg_goals_per_game
    # Find the team_id and name of the team w/ highest avg goals
    best_offense_id = team_goals_per_game.max_by {|team_id, avg_goals| avg_goals}[0]
    @teams.find { |team| team[:team_id] == best_offense_id }[:teamname]
  end

  def worst_offense
    team_goals_per_game = avg_goals_per_game
    worst_offense_id = team_goals_per_game.min_by { |team_id, avg_goals| avg_goals }[0]
    @teams.find { |team| team[:team_id] == worst_offense_id }[:teamname]
  end

  def highest_scoring_visitor
    average_scores_for_all_visitors
    @teams.find { |team| team[:team_id].to_i == @visitor_hash.key(@visitor_hash.values.max) }[:teamname]
  end

  def highest_scoring_home_team
    average_scores_for_all_home_teams
    @teams.find { |team| team[:team_id].to_i == @home_hash.key(@home_hash.values.max) }[:teamname]
  end

  def lowest_scoring_visitor
    average_scores_for_all_visitors
    @teams.find { |team| team[:team_id].to_i == @visitor_hash.key(@visitor_hash.values.min) }[:teamname]
  end

  def lowest_scoring_home_team
    average_scores_for_all_home_teams
    @teams.find { |team| team[:team_id].to_i == @home_hash.key(@home_hash.values.min) }[:teamname]
  end
end
