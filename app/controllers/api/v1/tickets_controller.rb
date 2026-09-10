module Api
  module V1
    class TicketsController < ApplicationController
      before_action :require_login

      def index
        tickets = current_user.organization.tickets.urgent_first

        render json: tickets.as_json(
          only: %i[id subject status priority resolved_at created_at]
        )
      end

      def show
        ticket = current_user.organization.tickets.find(params[:id])

        render json: ticket.as_json(
          only: %i[
            id
            subject
            description
            status
            priority
            resolved_at
            created_at
          ]
        )
      end

      def create
        ticket = current_user.organization.tickets.new(ticket_params)

        if ticket.save
          render json: ticket, status: :created
        else
          render json: { errors: ticket.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def update
        ticket = current_user.organization.tickets.find(params[:id])

        if ticket.update(ticket_params)
          render json: ticket
        else
          render json: { errors: ticket.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      private

      def ticket_params
        params.require(:ticket).permit(
          :subject,
          :description,
          :priority
        )
      end
    end
  end
end