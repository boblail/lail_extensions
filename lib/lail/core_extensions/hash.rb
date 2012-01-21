module Lail
  module CoreExtensions
    module Hash
      
      
      
      # def pick(*picks)
      #   picks = picks.flatten
      #   picks.inject({}) {|result, key| self.key?(key) ? result.merge(key => self[key]) : result}
      # end
      
      def pick(*picks)
        picks = picks.flatten
        
        mapped_picks = {}
        picks.each do |pick|
          if pick.is_a?(Hash)
            mapped_picks.merge!(pick)
          else
            mapped_picks[pick] = pick
          end
        end
        
        mapped_picks.inject({}) do |result, (key, new_key)|
          result[new_key] = self[key] if self.key?(key)
          result
        end
      end
      
      
      
      def pick!(*picks)
        picks = picks.flatten
        keys.each {|key| self.delete(key) unless picks.member?(key) }
      end
      
      
      
      def except(*picks)
        result = self.dup
        result.except!(*picks)
        result
      end
      
      
      
      def except!(*picks)
        picks = picks.flatten
        keys.each {|key| self.delete(key) if picks.member?(key) }
      end
      
      
      
      def inspect!(depth=0)
        s = ""
        self.each do |k,v|
          s << (" " * depth)
          s << k
          s << ": "
          if v.is_a?(Hash)
            s << "{\n"
            s << v.inspect!(depth + 2)
            s << (" " * depth)
            s << "}"
          elsif v.is_a?(Array)
            s << v.inspect
          else
            s << v.to_s
          end
          s << "\n"
        end
        s
      end
      
      
      
    end
  end
end

Hash.send :include, Lail::CoreExtensions::Hash
