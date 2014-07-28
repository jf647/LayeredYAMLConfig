# based on Hash traverse from Ruby Facets (https://github.com/rubyworks/facets)
class Array
  def traverse(&blk)
    reduce([]) do |a, e|
      case e
      when Hash
        e = e.traverse(&blk)
      when Array
        e = e.traverse(&blk)
      end
      ne = blk.call(e)
      a.push ne
      a
    end
  end
end
