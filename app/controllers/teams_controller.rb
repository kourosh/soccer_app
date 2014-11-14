class TeamsController < ApplicationController
	
	# Method to display all the teams. Result will be shown on 
	# the view app/views/teams/index.html.erb
	def index
		@teams = Team.all
	end

	def create
		Team.create(team_params)

		redirect_to "/"
	end

	# Method to create a new team. User will input 
	# the data on app/views/teams/new
	def new
		@team = Team.new
	end

	# Method to edit a particular team. User edits the 
	# data on app/views/teams/:id
	def edit
		@team = Team.find(params[:id])
	end

	# Method to show information about a particular 
	# team. Also returns information about players 
	# on the team.
	def show
		@team = Team.find(params[:id])
		@player = @team.players
	end

	# Method to update the database record of a specific
	# team. This works in tandem with the edit method above
	# after the user clicks the save button and submits
	# the data.
	# Also note that this method deletes a team if the
	# user presses the delete button on the view. If the
	# delete button is clicked, method calls the "destroy"
	# method below.
	def update
		if params[:delete]
			destroy
		else
			team = Team.find(params[:id])
			team.update(team_params)
			redirect_to "/"
		end
	end

	# Method to delete a team. This is called when a user
	# clicks the "Delete" button on the team edit page. 
	# It is called through the update method above.
	def destroy
		team = Team.find(params[:id])
		team.destroy
		redirect_to "/"
	end

 private
 	def team_params
 		params.require(:team).permit(:name, :country)
 	end

end
