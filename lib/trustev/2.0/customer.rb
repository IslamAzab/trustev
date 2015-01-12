module Trustev
  class Customer < CaseAttribute

    SERVICE_URL = 'customer'

    def initialize(case_id, opts)
      raise Error.new('Case ID is required') if case_id.nil?

      @case_id = case_id
      @opts = opts
    end

    def create
      Trustev.send_request url, build, 'POST'
    end

    def retrieve
      raise Error.new('ID is required') if @opts[:id].nil?
      Trustev.send_request url(true), {}, 'GET'
    end

    def update
      raise Error.new('ID is required') if @opts[:id].nil?
      Trustev.send_request url(true), build, 'PUT'
    end

    private

    def build
      {
        Id: @opts[:id],
        FirstName: @opts[:first_name],
        LastName: @opts[:last_name],
        Emails: @opts[:emails],
        PhoneNumber: @opts[:phone_number],
        DateOfBirth: @opts[:dob],
        Addresses: @opts[:addresses],
        SocialAccounts: @opts[:social_accounts]
      }
    end
  end
end
