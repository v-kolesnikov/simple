require 'test_helper'
require 'finite_automata'

module FiniteAutomata
  class DFARuleBookTest < Minitest::Test
    def test_next_state
      rules = [
        FARule.new(1, 'a', 2), FARule.new(1, 'b', 2),
        FARule.new(2, 'a', 3), FARule.new(2, 'b', 3),
        FARule.new(3, 'a', 3), FARule.new(3, 'b', 3)
      ]

      book = DFARulebook.new(rules)

      assert { book.next_state(1, 'a') == 2 }
      assert { book.next_state(1, 'b') == 2 }
      assert { book.next_state(2, 'b') == 3 }
    end
  end
end
