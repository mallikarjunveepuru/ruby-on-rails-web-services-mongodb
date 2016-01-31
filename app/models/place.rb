class Place
  class << self
    def mongo_client; Mongoid::Clients.default; end
    def collection; self.mongo_client[:places]; end
    def load_all(json_file); self.collection.insert_many JSON.parse(json_file.read); end
  end
end