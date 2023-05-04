class ConverterController < ApplicationController
  before_action :validate, only: [:convert]
  def index
  end

  def convert
  end

  def validate
    if validate_quantity
      puts toto
    end
    validate_currency(params['source_currency'])
    validate_currency(params['target_currency'])
  end

  def validate_quantity?
    begin
      Float(params['quantity'])
    rescue
      return false
    end
    return true
  end

  def validate_currency(currency)
    currency in %w[EUR BTC DOGE USD YEN]
  end
end
