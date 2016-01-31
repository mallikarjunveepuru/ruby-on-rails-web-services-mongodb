class Point
  attr_accessor :longitude, :latitude

  def to_hash
    {type: 'Point', coordinates: [@longitude, @latitude], lat: @latitude, lng: @longitude}
  end

  def initialize(params)
    if params[:coordinates]
      @longitude, @latitude = params[:coordinates]
    else
      @longitude, @latitude = params[:lng], params[:lat]
    end
  end
end