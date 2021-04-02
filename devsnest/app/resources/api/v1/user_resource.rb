# frozen_string_literal: true

module Api
  module V1
    class UserResource < JSONAPI::Resource
      attributes :email, :name, :password, :discord_id, :web_active, :username, :score, :discord_active
      attributes :group_id

      def fetchable_fields
        if context[:user].nil? || context[:user].id == @model.id
          super - [:password]
        else
          super - %i[password email]
        end
      end

      def group_id
        return nil if context[:user].nil?

        member = GroupMember.where(user_id: context[:user].id).first
        member.present? ? member.group_id : nil
      end
    end
  end
end
