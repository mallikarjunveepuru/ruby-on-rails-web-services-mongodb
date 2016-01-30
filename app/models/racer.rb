class Racer
  COLUMNS = [:number, :first_name, :last_name, :gender, :group, :secs]
  attr_accessor :id, *COLUMNS

  def self.mongo_client
    Mongoid::Clients.default
  end

  def self.collection
    self.mongo_client['racers']
  end

  def self.all(prototype={}, sort={}, skip=0, limit=nil)
    result = collection.find(prototype).sort(sort).skip(skip)
    if limit then result.limit(limit) else result end
  end

  def self.find id
    Rails.logger.debug {"finding racer ##{id}"}

    doc = collection.find(_id: id).first
    doc.nil? ? nil : Racer.new(doc)
  end

  def save
    Rails.logger.debug {"saving: #{self}"}

    record = COLUMNS.reduce({}){|r, sym| r[sym] = instance_variable_get("@#{sym}".to_sym); r}
    record[:_id] = @id if @id
    r = self.class.collection.insert_one(record)

    @id = r.inserted_id if r.successful?
    r.successful?
  end

  def initialize(params={})
    @id = params[:_id].nil? ? params[:id] : params[:_id].to_s

    %i[first_name last_name gender group].each do |sym|
      v = params.send(:[], sym)
      instance_variable_set("@#{sym}".to_sym, v)
    end
    @number = params[:number].to_i
    @secs = params[:secs].to_i
  end
end