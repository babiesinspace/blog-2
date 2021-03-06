class ArticlesController < ApplicationController
  include ArticlesHelper
  before_filter :require_login, except: [ :index, :show ]

  def index
    @articles = Article.all 
  end 

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id 
  end 

  def new 
    @article = Article.new 
  end 

  #Is it better to store 'article_params' in helper or private method?
  def create
    @article = Article.new(article_params)
    @article.save

    flash.notice = "Article '#{@article.title}' Was Created Successfully!"

    redirect_to article_path(@article)
  end 

  def destroy
    @article = Article.find(params[:id])
    
    @article.destroy

    flash.notice = "Article '#{@article.title}' Deleted!"

    redirect_to articles_path
  end 

  def edit
    @article = Article.find(params[:id])
  end 

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end

#Must update article table to hold author_id reference. Then add feature to only allow editing or
# deleting on authored posts

  # def authorized_to_modify?
  #   @article.author_id == current_user
  # end  

end
