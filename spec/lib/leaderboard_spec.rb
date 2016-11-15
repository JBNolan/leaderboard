require 'spec_helper'
require_relative "../../lib/team"

RSpec.describe Leaderboard do
  let(:leaderboard) { leaderboard = Leaderboard.new}

  describe "#initialize" do
    it "returns an empty @teams instance method" do
      expect(leaderboard.teams).to eq([])
    end
  end

  describe "#populate_teams" do
    it "populates @teams array with team objects" do
      expect(leaderboard.populate_teams).to eq(leaderboard.teams)
    end
  end

  describe "#records" do
    it "populates wins and losses for each team (most wins)" do
      leaderboard.populate_teams
      leaderboard.records
      expect(leaderboard.teams[0].wins).to eq(3)
    end

    it "populates wins and losses for each team (least wins)" do
      leaderboard.populate_teams
      leaderboard.records
      expect(leaderboard.teams[2].losses).to eq(2)
    end
  end

  describe "#record_sort" do
    it "sorts teams records by loss from least to greatest (least losses)" do
      leaderboard.populate_teams
      leaderboard.records
      leaderboard.record_sort
      expect(leaderboard.teams[0].losses).to eq(0)
    end

    it "sorts teams records by loss from least to greatest (most losses)" do
      leaderboard.populate_teams
      leaderboard.records
      leaderboard.record_sort
      expect(leaderboard.teams[-1].losses).to eq(2)
    end
  end

  describe "#team_rank" do
    it "populates each team objects' rank" do
      leaderboard.populate_teams
      leaderboard.records
      leaderboard.record_sort
      leaderboard.team_rank
      expect(leaderboard.teams[0].rank).to eq(1)
    end

    it "populates each team objects' rank" do
      leaderboard.populate_teams
      leaderboard.records
      leaderboard.record_sort
      leaderboard.team_rank
      expect(leaderboard.teams[-1].rank).to eq(4)
    end
  end

  describe "#team_game_summary" do
    it "takes a parameter of a team object and prints details about each game that team played" do
      leaderboard.populate_teams
      expect(leaderboard.team_game_summary("Colts")).to eq("Colts played 2 games.\nThey played as the away team against the Broncos and lost: 24 to 7.\nThey played as the away team against the Patriots and lost: 21 to 17.\n")
    end
  end
end
