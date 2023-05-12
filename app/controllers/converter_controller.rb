require 'net/http'
require 'json'

class ConverterController < ApplicationController
  before_action :validate, only: [:convert]
  def index
  end

  def convert
    # https://exchangerate.host/#/docs
    url = "https://api.exchangerate.host/convert?from=#{params['source_currency']}&to=#{params['target_currency']}&amount=#{params['quantity']}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    response_obj = JSON.parse(response)

    # debugger
    render :index
  end

  def validate
    @errors = ActiveModel::Errors.new(self)
    validate_quantity
    validate_currency(params['source_currency'])
    validate_currency(params['target_currency'])
  end

  def validate_quantity
    Float(params['quantity'])
  rescue
    @errors.add :quantity, :not_a_number, message: "Quantity must be a number"
  end

  def validate_currency(currency)
    @errors.add :currency, :unknown_currency, message: "Currency #{currency} is not in EUR BTC DOGE USD YEN " unless currency in %w[EUR BTC DOGE USD YEN]
  end
end
