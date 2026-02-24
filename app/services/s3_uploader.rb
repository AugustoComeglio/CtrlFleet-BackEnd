# frozen_string_literal: true

require 'aws-sdk-s3'

module S3Uploader
  module ModuleMethods
    def get_upload_key(prefix, filename)
      extname = File.extname(filename)
      filename = "report_#{Time.zone.now.strftime('%Y%m%d%H%M%S')}#{extname}"
      Pathname.new(prefix).join(filename).to_s
    end

    def generate_upload_url(file_name, timeout_in_seconds = 900, method = :get_object)
      Aws::S3::Presigner.new.presigned_url(
        method,
        bucket: bucket_name,
        key: file_name,
        expires_in: timeout_in_seconds
      )
    end

    # Upload file and return URL
    def upload_file(upload_key, file)
      Aws.config.update({
                          region: bucket_region,
                          credentials: Aws::Credentials.new(bucket_access_key_id, bucket_secret_access_key)
                        })

      s3_bucket = Aws::S3::Resource.new.bucket(bucket_name)

      obj = s3_bucket.object(upload_key)
      
      obj.upload_file(file)

      generate_upload_url obj.key
    end

    def download_file(key)
      client = Aws::S3::Client.new(
        region: bucket_region,
        credentials: Aws::Credentials.new(bucket_access_key_id, bucket_secret_access_key)
      )

      client.get_object({ bucket: bucket_name, key: key })
    end

    def bucket_name
      'ctrlfleet'
    end

    def bucket_region
      'us-east-2'
    end

    def bucket_access_key_id
      'AKIA37KR6V7C3PNBAPM3'
    end

    def bucket_secret_access_key
      'Uc2lpPdrOtrs4G+sDxO1EC8gIJ8aToXaRNJCrcsn'
    end
  end
  extend ModuleMethods
end
