# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain actions with simple logic
    module ConfessionsControllerSimpleActions
      extend ActiveSupport::Concern

      included do
        def index
          respond_to do |format|
            format.html
            format.turbo_stream
          end
        end

        def show; end

        def new
          @confession = Confession.new
        end
      end
    end
  end
end
