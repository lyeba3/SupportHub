class TicketsController < ApplicationController
  before_action :require_login
  before_action :set_organization

  def index
  @tickets = Rails.cache.fetch("tickets/urgent_first", expires_in: 5.minutes) do
    Ticket.urgent_first.to_a
  end
 end

  def show
    @ticket = current_user.organization.tickets.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      redirect_to @ticket, notice: "Ticket created", status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def resolve
    @ticket = current_user.organization.tickets.find(params[:id])

    ResolveTicket.call(
      ticket: @ticket,
      actor: current_user
    )

    redirect_to @ticket, notice: "Ticket resolved", status: :see_other
  end

  def attachment
    @ticket = current_user.organization.tickets.find(params[:id])

    unless @ticket.attachment.attached?
      head :not_found
      return
    end

    redirect_to rails_blob_path(
      @ticket.attachment,
      disposition: "inline"
    )
  end

  private

  def ticket_params
    params.require(:ticket).permit(
      :organization_id,
      :subject,
      :description,
      :priority,
      :attachment
    )
  end

  def set_organization
    @organization = current_user.organization
  end
end