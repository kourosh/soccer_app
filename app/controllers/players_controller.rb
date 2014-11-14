class PlayersController < ApplicationController
	before_filter :assign_team, only: [:new, :edit]
	before_filter :assign_player, only: [:edit, :update]

	# Method to generate an index of all the players for  
	# a particular team. Corresponding view is
	# app/views/players/index
	def index
		@team = Team.find(params[:team_id])
	end

	# Method to create a database record with player info
	# gathered from the teams/team_id/players view
	def create
		Player.create(player_params.merge(team_id: params[:team_id]))

		redirect_to "/"
	end

	# Method to create a new player. Corresponding view 
	# is app/views/teams/team_id/players/new.
	def new
		@player = Player.new
	end

	def edit
		@team = Team.find(params[:team_id])
		@player = Player.find(params[:id])
	end

	def show
		@team = Team.find(params[:team_id])
		@player = @team.players.find(params[:id])
	end

	def update
		if params[:delete]
			destroy
		else
			@player.update(player_params)
			redirect_to "/"
		end
	end

	def destroy
		player = Player.find(params[:id])
		player.destroy
		redirect_to "/"
	end

private
	def player_params
		params.require(:player).permit(:name, :jersey)
	end

	def assign_team
		@team = Team.find(params[:team_id])
	end

	def assign_player
		@player = Player.find(params[:id])
	end

end
