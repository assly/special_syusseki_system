class TimecardsController < ApplicationController
  before_action :logged_in_teacher

  def index
    @students = current_teacher.students
  end

  def student_index
    @student = Student.find(params[:id])
    @timecards = @student.timecards.order('created_at DESC')
  end

  def show
    @timecard = Timecard.find(params[:id])
  end

  def update
    timecard = Timecard.find(params[:id])
    timecard.update_attributes(status: params[:status])
    flash[:success] = '更新しました、反映されているか確認してください'
    redirect_to timecard
  end

  private

  def timecard_update_params
    params
      .require(:timecard)
      .permit(:status)
  end

  def logged_in_teacher
    return if teacher_logged_in?
    flash[:danger] = '教員ログインが必要なページです'
    redirect_to teacher_login_url
  end
end