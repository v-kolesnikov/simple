module FiniteAutomata
  class FARule < Struct.new(:state, :character, :next_state)
    def applies_to?(state, character)
      [self.state, self.character] == [state, character]
    end

    def follow
      next_state
    end

    def inspect
      "#<#{self.class.name} #{state.inspect} --#{character}--> #{next_state}>"
    end
  end
end
