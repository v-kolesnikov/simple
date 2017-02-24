module FiniteAutomata
  class DFARulebook < Struct.new(:rules)
    def next_state(state, character)
      rule_for(state, character).follow
    end

    def rule_for(state, character)
      rules.detect do |rule|
        rule.applies_to?(state, character)
      end
    end

    def inspect
      rules.map(&:inspect).join("\n")
    end
  end
end
