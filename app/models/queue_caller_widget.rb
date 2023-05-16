class QueueCallerWidget < Widget
  attr_json :pdvs_to_check, :string, array: true
  attr_json :pdvlivre_path, :string
  attr_json :samba_settings, JsonTypes::SambaSettings.to_type

  has_one :media, as: :attachable, dependent: :delete
  has_one :attachment, through: :media

  def queue
    if samba_settings
      client = samba_settings.samba_connection
      files = client.ls
                    .select { |key, _val| key.starts_with?('Pdv') && key.ends_with?(*pdvs_to_check.join(';').split(';')) }
                    .sort_by { |_k, v| v[:modified].to_datetime.to_i }
                    .map { |i| { filename: i[0], modified: i[1][:modified], number: i[0].split('.')[1] } }
                    .reverse
      files.each do |file|
        client.del("Pdv.#{file[:number]}") if client.exists?("Pdv.#{file[:number]}")
      end

      client.close
      files
    else
      [{ filename: 'Pdv.002', modified: Time.now, number: '002' },
       { filename: 'Pdv.003', modified: Time.now, number: '003' }, { filename: 'Pdv.003', modified: Time.now, number: '004' }, { filename: 'Pdv.003', modified: Time.now, number: '005' }]
    end
  end
end
