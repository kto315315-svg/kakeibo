class RecordsController < ApplicationController
    before_action :authenticate_user!
  before_action :set_record, only: [:show, :edit, :update, :destroy]

  def index
    @records = current_user.records.order(date: :desc)
  
    # 検索・絞り込み
    @records = @records.where(category_id: params[:category_id]) if params[:category_id].present?
    @records = @records.where(income_or_expense: params[:income_or_expense]) if params[:income_or_expense].present?
    @records = @records.where("memo LIKE ?", "%#{params[:keyword]}%") if params[:keyword].present?
  
    # 月別集計
    @year  = (params[:year] || Date.today.year).to_i
    @month = (params[:month] || Date.today.month).to_i
  
    @monthly_records = current_user.records.where(
      date: Date.new(@year, @month, 1)..Date.new(@year, @month, -1)
    )
  
    @income  = @monthly_records.where(income_or_expense: "収入").sum(:amount)
    @expense = @monthly_records.where(income_or_expense: "支出").sum(:amount)
    @balance = @income - @expense
  
    # グラフ用データ（カテゴリ別支出）
    @chart_data = @monthly_records
      .where(income_or_expense: "支出")
      .joins(:category)
      .group("categories.name")
      .sum(:amount)

      # 貯金グラフ用データ（過去6ヶ月）
      @savings_data = []
      6.times do |i|
        target_date = Date.today - i.months
        monthly = current_user.records.where(
          date: target_date.beginning_of_month..target_date.end_of_month
        )
        income  = monthly.where(income_or_expense: "収入").sum(:amount)
        expense = monthly.where(income_or_expense: "支出").sum(:amount)
        @savings_data.unshift({
          month: target_date.strftime("%m月"),
          income: income,
          expense: expense,
          balance: income - expense
        })
      end
  end

  def show
  end

  def new
    @record = Record.new
  end

  def create
    @record = current_user.records.build(record_params)
    if @record.save
      redirect_to records_path, notice: "収支を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @record.update(record_params)
      redirect_to records_path, notice: "収支を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @record.destroy
    redirect_to records_path, notice: "収支を削除しました"
  end

  private

  def set_record
    @record = current_user.records.find(params[:id])
  end

  def record_params
    params.require(:record).permit(:amount, :date, :memo, :income_or_expense, :category_id, tag_ids: [])
  end
end
