class BudgetsController < ApplicationController

before_action :find_budget, only: [:update, :destroy]

def create
	@budget = Budget.new(budget_params)
	@budget.attributes = params[:budget].permit(:budget, :date_from, :date_to)
  @budget.user_id = current_user.id
	if @budget.save
		flash[:notice] = "Successfully added your budget"	
	else
		flash[:alert] = @budget.errors.full_messages.join("<br />")
	end
	redirect_to trips_path
end

def update
	@budget.attributes = params[:budget].permit(:budget, :date_from, :date_to)
  @budget.user_id = current_user.id
	if @budget.update(budget_params)
		flash[:notice] = "Successfully added your budget"
	else
		flash[:alert] = @budget.errors.full_messages.join("<br />")
	end
	redirect_to trips_path
end

def destroy
	@budget.destroy
	flash[:notice] = "Successfully deleted your budget"
	redirect_to trips_path
end

private

	def budget_params
		params.require(:budget).permit(:budget, :date_from, :date_to)
	end

	def find_budget
		@budget = Budget.find(params[:id])
	end

end