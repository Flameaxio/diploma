# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.api_name = 'Diploma Project'
  config.format = [:json]
  config.curl_headers_to_filter = %w(Host Cookie)
  config.curl_host = 'http://localhost'
  config.disable_dsl_status!
end


module MyLetDeclarations
  extend RSpec::SharedContext
  let(:parsed_response) { JSON.parse(response_body, object_class:OpenStruct) }
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.before(:all) do
    puts "\n\n\n\n==================  Running #{self.class.description} =========================\n\n"
  end
  config.before(:each) do
    puts "\n\n==================  Executing #{example.description} =========================\n\n"
  rescue StandardError
    # Ignored
  end

  config.include MyLetDeclarations
end

module TestData
  extend self

  def email
    'test@email.com'
  end

  def mobile_number
    '+380502118725'
  end

  def pwd
    'StrongPassword1234'
  end
end

# Monkey patch according to https://github.com/zipmark/rspec_api_documentation/issues/456
module RspecApiDocumentation
  class RackTestClient < ClientBase
    def response_body
      last_response.body.encode('utf-8')
    rescue Encoding::UndefinedConversionError
      'Large binary'
    end
  end
end

