module RacersHelper

  def toRacer(v)
    v.is_a?(Racer) ? v : Racer.new(v)
  end
end
