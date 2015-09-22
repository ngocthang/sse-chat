class CommentsController < ApplicationController
  include ActionController::Live

  def index
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream)
    begin
      Comment.on_change do |id|
        comment = Comment.find(id)
        t = render_to_string(partial: 'comment', formats: [:html], locals: {comment: comment})
        sse.write(t)
      end
    rescue IOError
      # Client Disconnected
    ensure
      sse.close
    end
    render nothing: true
  end

  def new
    @comment = Comment.new
    @comments = Comment.order('created_at DESC')
  end

  def create
    respond_to do |format|
      if current_user
        @comment = current_user.comments.build(comment_params)
        @comment.save
        format.html {redirect_to root_url}
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
