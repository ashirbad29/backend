# frozen_string_literal: true

module Api
  module V1
    class GroupMembersController < ApplicationController
      include JSONAPI::ActsAsResourceController
      before_action :simple_auth
      before_action :check_authorization

      def context
        { user: @current_user }
      end

      def check_authorization
        group = Group.find_by(id: params[:group_id])
        return render_not_found unless group.present?

        return render_forbidden unless group.check_auth(@current_user)
      end
    end
  end
end
