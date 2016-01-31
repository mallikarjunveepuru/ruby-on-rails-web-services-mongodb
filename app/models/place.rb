class Place
  attr_accessor :id, :formatted_address, :location, :address_components

  class << self
    def mongo_client; Mongoid::Clients.default; end
    def collection; self.mongo_client[:places]; end
    def load_all(json_file); self.collection.insert_many JSON.parse(json_file.read); end

    def find_by_short_name(short_name)
      collection.find({'address_components.short_name': short_name})
    end

    def to_places(view); view.map {|e| Place.new(e)}; end

    def find(id); doc = _find(id).first; doc ? Place.new(doc) : doc; end

    def all(offset = 0, limit = nil)
      v = collection.find.skip(offset)
      v = v.limit(limit) if limit
      to_places v
    end

    def _find(id); collection.find({_id: BSON.ObjectId(id)}); end
  end

  def initialize(params)
    @id = params[:_id].to_s
    @formatted_address = params[:formatted_address]
    @location = Point.new params[:geometry][:geolocation]
    @address_components = params[:address_components].map {|c| AddressComponent.new(c)}
  end

  def destroy; Place._find(@id).delete_one; end
end