class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_emails, only: :index
  
  def index
    @posts = Post.all
  end

  def show
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params.require(:post).permit(:heading,:body))
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def set_post
    @post = Post.find(params[:id])
  end
  
  def check_emails
    @emails = []
    Gmail.connect('feliks.montez', 'Inten$1ty()') do |gmail|
      gmail.inbox.find(:unread).each do |email|
        email.read!
        if email.subject =~ /SMS/
          @emails << email
        end
      end
    end
    
    process_emails(@emails)
  end
  
  def process_emails(emails)
    emails.each do |email|
      author = email.from[0].name.chomp
      body = email.body.decoded.gsub(/[\w\W]*Content-Type:\stext\/plain.*?\n\n/, '').gsub(/\n\n--[\w\W]*--/, '').chomp
      heading, body = body.split('*body*')
      @post = Post.create(heading: heading, body: body)
    end
  end
end
