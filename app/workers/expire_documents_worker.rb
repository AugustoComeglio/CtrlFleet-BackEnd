class ExpireDocumentsWorker
  include Sidekiq::Worker

  def perform
    Document.where('expires_in <= ?', Time.zone.now).each do |doc|
      doc.change_state!('expirado')
      message = "Tu documento #{doc.title} alcanzo la fecha de expiración (#{doc.expires_in.strftime("%d/%M/%Y")}).
                  Ya no esta disponible. Por favor actualiza tu documentacion #{doc.title} a uno vigente."

      send_notificacion(doc.user, 'Documento expirado', message, doc.id) if doc.user
      send_notificacion(doc.manager, 'Documento expirado', message, doc.id)
    end

    Document.where('expires_in <= ?', Time.zone.today + 15.days).each do |doc|
      message = "Tu documento #{doc.title} esta pronto a alcanzar la fecha de expiración (#{doc.expires_in.strftime("%d/%M/%Y")}).
                Por favor actualiza tu documentacion #{doc.title} a uno vigente antes que expire."

      send_notificacion(doc.user, 'Tienes un documento pronto a expirar', message, doc.id) if doc.user
      send_notificacion(doc.manager, 'Tienes un documento pronto a expirar', message, doc.id)
    end
  end

  def send_notificacion(user, title, msg, doc_id)
    NotificationService.new(user, title, msg, doc_id, 'Document').exec
  end
end
