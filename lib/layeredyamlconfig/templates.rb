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
      success = 0
      failure = 0
      newcfg = @cfg.traverse do |v|
        if v.is_a?(String) && v.match(/^<%=/)
          begin
            nv = Erubis::TinyEruby.new(v).evaluate(cfg: @cfg)
            if !self.class.emptyok && nv.empty?
              failure += 1
              v
            elsif !nv.match(/^<%=/)
              success += 1
              nv
            else
              failure += 1
              v
            end
          rescue
            failure += 1
            v
          end
        else
          v
        end
      end
      @cfg = newcfg
      # all success
      if 0 == failure
        return
      # all failure
      elsif 0 == success
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
end
