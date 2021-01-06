class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  # @prototype = Prototype.find(params[:id]) をまとめて読み込み
  before_action :authenticate_user!, except: [:index, :show]
  # prototypeディレクトリのビューはindexとshow「以外」ログイン必須
  before_action :move_to_root, only: [:edit, :update, :destroy]
  # 直接URLを打ち込んでアクセスしても、current_userと一致しなければリダイレクトする

  def index
    @prototypes = Prototype.includes(:user)
    # @prototypes = Prototype.all だとN+1問題で負担がかかる処理になる
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    # createで保存すると以下if~endの処理を挟めないので、new~saveに分解する
    if @prototype.save
      redirect_to prototype_path(@prototype.id)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit
    end
  end

  def destroy
    prototype.destroy
    redirect_to root_path
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_root
    redirect_to root_path unless current_user == @prototype.user
  end

end
