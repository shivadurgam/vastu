json.array!(@pics) do |pic|
  json.extract! pic, :id, :picture
  json.url pic_url(pic, format: :json)
end
