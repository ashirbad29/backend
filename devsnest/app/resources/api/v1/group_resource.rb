# frozen_string_literal: true

module Api
  module V1
    class GroupResource < JSONAPI::Resource
      attributes :name, :owner_id, :co_owner_id, :members_count, :student_mentor_id, :owner_name, :co_owner_name, :batch_leader_id, :slug
      has_many :group_members
      
      def self.records(options = {})
        user = options[:context][:user]
        group_ids = user.fetch_group_ids                       
        super(options).where(id: group_ids)
      end      
    end    
  end
end