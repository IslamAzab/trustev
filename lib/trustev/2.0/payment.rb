module Trustev
  class Payment < CaseAttribute

    SERVICE_URL = 'payment'

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

    def retrieve_all
      Trustev.send_request url, {}, 'GET'
    end

    def update
      raise Error.new('ID is required') if @opts[:id].nil?
      Trustev.send_request url(true), build, 'PUT'
    end

    private

    def build
      {
        Id: @opts[:id],
        PaymentType: @opts[:payment_type],
        BINNumber: @opts[:bin_number]
      }
    end
  end
end
