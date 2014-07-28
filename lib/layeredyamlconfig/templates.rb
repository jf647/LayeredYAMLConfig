# a config class made up of multiple layers, with later ones overriding earlier ones
class LayeredYAMLConfig
  def resolve_templates
    # lazy-load dependencies
    require 'erubis/tiny' unless defined?(TinyEruby)

    # if templates are enabled:
    # - walk the tree finding String leaves that look like ERB tags
    # - evaluate them with self as context
    # - rescue errors and increment success / failure counts
    # - A: if we saw no failures, we're done
    # - B: if we saw no successes for the first time, set a flag
    #      if we saw no failures for the second time, raise
    # - otherwise keep going until A or B are true
    all_failed_once = false
    loop do
      counts = { s: 0, f: 0 }
      newcfg = @cfg.traverse do |v|
        resolve_one_pass(v, counts)
      end
      @cfg = newcfg
      # all counts[:s]
      if 0 == counts[:f]
        return
      # all counts[:f]
      elsif 0 == counts[:s]
        if all_failed_once
          fail 'all template evaluation failed'
        else
          all_failed_once = true
        end
      # mix
      else
        all_failed_once = false
      end
    end
  end

  private

  def resolve_one_pass(v, counts)
    if v.is_a?(String) && v.match(/^<%=/)
      begin
        resolve_one_value(v, counts)
      rescue
        counts[:f] += 1
        v
      end
    else
      v
    end
  end

  def resolve_one_value(v, counts)
    nv = Erubis::TinyEruby.new(v).evaluate(cfg: @cfg)
    if !self.class.emptyok && nv.empty?
      counts[:f] += 1
      v
    elsif !nv.match(/^<%=/)
      counts[:s] += 1
      nv
    else
      counts[:f] += 1
      v
    end
  end
end
