module FiniteAutomata
  class DFA < Struct.new(:current_state, :accept_states, :rulebook)
    def accepting?
      accept_states.include?(current_state)
    end

    def read_character(char)
      self.current_state = rulebook.next_state(current_state, char)
    end
  end
end
