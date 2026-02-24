# frozen_string_literal: true

module Api
  module V1
    class DebatesController < Api::BaseController
      before_action :find_debate, only: %i[show update destroy units]

      def index
        @debates = Debate.order(:begin_at)

        render json: { data: @debates.as_json(only: %i[id subject begin_at], methods: %i[started last_response responses_count]) }, status: :ok
      end

      def show
        if @debate
          render json: { data: @debate.as_json(only: %i[id subject description begin_at],
                                               methods: %i[started],
                                               include: { responses: { only: %i[id details created_at],
                                                                       methods: %i[started] } }) },
                 status: :ok
        else
          render json: { message: "Debate #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def create
        @debate = Debate.new debate_params
        @debate.user_id = current_user_id

        if @debate.save
          render json: { data: @debate.as_json(only: %i[id subject description begin_at],
                                               methods: %i[started],
                                               include: { responses: { only: %i[id details created_at],
                                                                       methods: %i[started] } }) },
                 status: :ok
        else
          render json: { message: @debate.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @debate.update debate_params
          render json: { data: @debate.as_json(only: %i[id subject description begin_at],
                                               methods: %i[started],
                                               include: { responses: { only: %i[id details created_at],
                                                                       methods: %i[started] } }) },
                 status: :ok
        else
          render json: { message: @debate.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @debate.destroy
          render json: { message: I18n.t(:debate_was_destroyed_successfully) }, status: :ok
        else
          render json: { message: @debate.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_debate
        @debate = Debate.find_by id: params[:id]
      end

      def debate_params
        params.require(:debate).permit :subject, :description, :begin_at, :end_at
      end
    end
  end
end
