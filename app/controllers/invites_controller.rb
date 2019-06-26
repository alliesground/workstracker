class InvitesController < ApplicationController
  before_action :authenticate_user!

  def create
    build_invite

    if @invite.save
      flash[:success] = "Invitation sent"
      redirect_to project_path @invite.invitable
    else
      render template: 'projects/show', 
             locals: { project: @invite.invitable,
                       invite: @invite }
    end
  end

  private

  def build_invite
    @invite = current_user.invites.build(invite_params)
    @invite.invitable_type = invitable_type
    @invite.invitable_id = invitable_id
  end

  def invitable_type
    params[:invite][:invitable_type]
  end

  def invitable_id
    params[:invite][:invitable_id]
  end

  def invite_params
    params.require(:invite).permit(:email)
  end
end
