# adapted from Ruby Facets (https://github.com/rubyworks/facets) to support nested Array traversal
# we're using the Ruby license, clause 2a by making LayeredYAMLConfig freely available
class Hash
  def traverse(&blk)
    reduce({}) do |h, (k, v)|
      case v
      when Hash
        v = v.traverse(&blk)
      when Array
        v = v.traverse(&blk)
      end
      nv = blk.call(v)
      h[k.to_sym] = nv
      h
    end
  end
end
