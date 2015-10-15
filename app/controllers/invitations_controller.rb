class InvitationsController < Devise::InvitationsController
  private

  # this is called when creating invitation
  # should return an instance of resource class
  def invite_resource
    ## skip sending emails on invite
    u = resource_class.invite!(invite_params, current_inviter) do |u|
      u.skip_invitation = true
      u.invitation_sent_at = DateTime.now
    end
    flash[:link] = accept_user_invitation_url(:invitation_token =>  u.raw_invitation_token)
    u
  end
end