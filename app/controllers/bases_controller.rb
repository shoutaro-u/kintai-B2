class BasesController < ApplicationController
  before_action :admin_user,     only: [:index, :new, :create, :update, :edit, :destroy]

  # 拠点一覧ページ
  def index
    @bases = Base.all.order('base_number')
    @base = Base.new
  end
  
  # 拠点情報の追加
  def new
    @base = Base.new
  end
  
  # 拠点情報の追加　作成
  def create
    @base = Base.create(base_params)
    flash[:success] = "拠点情報を追加しました。"
    redirect_to bases_path
  end
  
  # 拠点情報の更新
  def update
    @base = Base.find(params[:id])
    @base.update(base_params)
    flash[:success] = "更新しました。"
    redirect_to bases_path
  end
  
  # 拠点情報の編集ページ
  def edit
    @base = Base.find(params[:id])
  end
  
  # 拠点情報の削除
  def destroy
    @base = Base.find(params[:id])
    @base.destroy
    flash[:success] = "削除しました。"
    redirect_to bases_path
  end
  
  private
  
  # 拠点情報の追加および編集で使用
  def base_params
    params.require(:base).permit(:base_number, :base_name, :base_info)
  end
  
  # 管理者かどうか確認
    def admin_user
      unless current_user.admin?
        flash[:danger] = "管理者権限がありません。"
        redirect_to(root_url)
      end
    end
    
end
