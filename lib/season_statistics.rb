require 'csv'
require 'pry'

module SeasonStatistics
  def winningest_coach(season)
    coach_stats_by_season(season)
    @coaches_wins_to_losses.key(@coaches_wins_to_losses.values.max)
  end

  def worst_coach(season)
    coach_stats_by_season(season)
    @coaches_wins_to_losses.key(@coaches_wins_to_losses.values.min)
  end

  def most_accurate_team(season)
    shots_to_goals = season_shots_to_goals(season)
    most_accurate_team_id = (shots_to_goals.min_by {|team_id, ratio| ratio})[0]
    @teams.find { |team| team[:team_id] == most_accurate_team_id }[:teamname]
  end

  def least_accurate_team(season)
    shots_to_goals = season_shots_to_goals(season)
    least_accurate_team_id = (shots_to_goals.max_by {|team_id, ratio| ratio})[0]
    @teams.find { |team| team[:team_id] == least_accurate_team_id }[:teamname]
  end

  def most_tackles(season)
    tackles_by_team(season)
    @teams.find { |team| team[:team_id] == @tackles_counter.key(@tackles_counter.values.max) }[:teamname]
  end

  def fewest_tackles(season)
    tackles_by_team(season)
    @teams.find { |team| team[:team_id] == @tackles_counter.key(@tackles_counter.values.min) }[:teamname]
  end
end