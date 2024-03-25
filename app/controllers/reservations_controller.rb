class ReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations #ログイン中のユーザのIDと、reservationの外部キー(user_id)が一致するreservation全て
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @room = @reservation.room
    @number_of_days = sum_of_days
    @total_charge = @room.charge * @number_of_days * sum_of_people
    if @reservation.invalid?
      render 'rooms/show'
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    if @reservation.save
      redirect_to reservations_path
    else
      render 'rooms/show'
    end
  end

  private
    def reservation_params
      params.require(:reservation).permit(:check_in, :check_out, :number_of_people, :user_id, :room_id)
    end

    def sum_of_days
      if @reservation.check_out.present? && @reservation.check_in.present?
        sum_of_days = (@reservation.check_out - @reservation.check_in).to_i
      else
        sum_of_days = 0
      end
    end

    def sum_of_people
      if @reservation.number_of_people.nil?
        sum_of_people = 0
      else
        sum_of_people = @reservation.number_of_people
      end
    end

end
