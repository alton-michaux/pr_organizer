require "google-apis-sheets_v4"
require_relative "google_credentials.rb"

class GoogleSheetsService
  include GoogleCredentials
  attr_reader :service

  def self.service
    new.service
  end

  private

  def initialize
    @service = freshly_authorized_service
  end

  def freshly_authorized_service
    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = ENV["APPLICATION_NAME"]
    service.authorization = make_credentials!
    service
  end
end  