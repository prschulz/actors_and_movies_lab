class CommentsController < ApplicationController
  before_action :find_commentable

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "You always got comments..."
    else
      flash[:alert] = "You cannot comment on this because Pete sucks at coding"
    end
    redirect_to :back
  end

  def delete
    @comment = comment_params
    @commentable.comments.delete @comment
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end


  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
