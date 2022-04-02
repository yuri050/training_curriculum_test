class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)  # Planという箱に(plan_params)というデータをcreate(保存する)
    redirect_to action: :index  # usersコントローラのindexアクションへリダイレクト
  end

  private  # クラス外から呼び出すことのできないメソッド

  def plan_params
    params.require(:calendars).permit(:date, :plan) 
    # パラメーター(params)の中からcalendarsを探す(requireする)→calendarsの中からdateとplanを探す(permitする)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ {Date.today.day: '1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x| # 7 から１つずつ順番に要素を取り出し変数 x に代入
      today_plans = []
      plans.each do |plan| # plans から１つずつ順番に要素を取り出し変数 plan に代入
        today_plans.push(plan.plan) if plan.date == @todays_get_date + x
      end
      days = {month:  (@todays_date + x).month, date:  (@todays_date+x).day, plans: today_plans}
      @week_days.push(days)
    end

  end
end
