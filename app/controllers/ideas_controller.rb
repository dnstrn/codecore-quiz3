class IdeasController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def new
    @idea = Idea.new
  end

  def create
    idea_params = params.require(:idea).permit(:title, :body)
    idea = Idea.new idea_params
    idea.user = current_user
    if idea.save
      redirect_to idea_path(idea), notice: "Eureka! Your Idea Was Submitted."
    else
      render :new
    end
  end

  def show
    @idea = Idea.find params[:id]
  end

  def index
    @ideas = Idea.all
  end

  def edit
    @idea = Idea.find params[:id]
  end

  def update
    idea_params = params.require(:idea).permit(:title, :body)
    idea = Idea.find params[:id]
    if idea.update idea_params
      redirect_to idea_path(idea), notice: "Idea Updated"
    else
      render :edit
    end
  end

  def destroy
    idea = Idea.find params[:id]
    idea.destroy
    redirect_to ideas_path, notice: "Idea Deleted"
  end

end
