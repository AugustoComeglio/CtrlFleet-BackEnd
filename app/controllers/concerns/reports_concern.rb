# encoding: utf-8
# frozen_string_literal: true

module ReportsConcern
  def export_report
    records = case @report.report_type
              when 'vehicles'
                Vehicle.where(id: record_ids).order(:created_at)
              when 'users'
                User.where(id: record_ids).order(:created_at)
              when 'fleets_per_warehouse'
                Fleet.where(id: record_ids)
              when 'spares'
                SpareWarehouse.where(id: record_ids)
              when 'spares_per_maintenance_plan', 'spares_per_vehicle'
                Spare.where(id: record_ids)
              when 'maintenance_plans'
                MaintenancePlan.with_deleted.where(id: record_ids).order(:created_at)
              when 'debates'
                Debate.where(id: record_ids).order(:begin_at)
              when 'failures'
                Failure.where(id: record_ids).order(:created_at)
              when 'fuel_records_per_fleet'
                FuelRecord.where(id: record_ids).order(:created_at)
              when 'kilometer_records_per_fleet'
                KilometerRecord.where(id: record_ids).order(:created_at)
              when 'gas_stations_ranking'
                GasStation.where(id: record_ids).order(:created_at)
              end

    date_range = @report.begin_at.beginning_of_day..@report.end_at.end_of_day
    filename = @report.report_types_hash[@report.report_type.to_sym].parameterize.gsub('-', '_')

    xlsx = ApplicationController.new.render_to_string layout: false, handlers: [:axlsx], formats: [:xlsx], template: "reports/#{@report.report_type}", locals: { records: records, date_range: date_range }
    create_xlsx(xlsx, "reporte_de_#{filename}_#{@report.begin_at.strftime('%d/%m/%Y')}_#{@report.end_at.strftime('%d/%m/%Y')}.xlsx", current_user.email, date_range)

    render json: { message: 'En breve recibira un correo electronico con el detalle del reporte generado.' }
  end

  private

  def find_report
    @report = Report.find_by id: params[:id]
  end

  def record_ids
    @report.record_ids.split(',')
  end

  def create_xlsx(xlsx, filename, email, date_range = nil)
    begin
      upload_key = S3Uploader.get_upload_key('reports', filename)
      temp = Tempfile.new(upload_key, encoding: 'ASCII-8BIT')
      temp.write xlsx
      public_url = S3Uploader.upload_file(upload_key, temp)

      ReportMailer.send_report(email, public_url, filename, date_range.to_s).deliver_now
    ensure
      temp.close
      temp.unlink
    end
  end
end
