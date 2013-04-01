# Class S3_backend
# Description: S3 back end for Hiera.
class Hiera
    module Backend
        class S3_backend
            def initialize
                require 'rubygems'
                require 'aws-sdk'
                Hiera.debug("S3_backend initialized")
            end
            def lookup(key, scope, order_override, resolution_type)
                key = key.gsub!('::','/')
                if defined? Config[:s3][:key]
                    s3 = AWS::S3.new(
                      :access_key_id     => Config[:s3][:key],
                      :secret_access_key => Config[:s3][:secret])
                else
                    # If credentials not defined, try IAM roles
                    s3 = AWS::S3.new()
                end
                answer = nil
                Backend.datasources(scope, order_override) do |source|
                    Hiera.debug("S3_backend invoked lookup")
                    begin
                        path = File.join(source, key)
                        answer = s3.buckets[Config[:s3][:bucket]].objects[path].read
                    rescue
                        Hiera.debug("Match not found in source " + source)
                    end
                end
                return answer
            end
        end
    end
end
