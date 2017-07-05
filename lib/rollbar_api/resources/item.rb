module RollbarApi
  class Item < Resource
    def self.get!(item_id)
      item = Request.get!("/api/1/item/#{item_id}")
      Resource.new(item)
    end
  end
