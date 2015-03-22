json.array!(@payments) do |payment|
  json.extract! payment, :id, :amount, :responseCode, :responseMessage, :xref, :amountReceived, :transactionID, :cardNumberMask, :cardTypeCode, :cardType
  json.url payment_url(payment, format: :json)
end
