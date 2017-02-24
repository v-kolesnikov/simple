require 'test_helper'
require 'finite_automata'

module FiniteAutomata
  class DFATest < Minitest::Test
    def setup
      rules = [
        FARule.new(1, 'a', 2), FARule.new(1, 'b', 1),
        FARule.new(2, 'a', 2), FARule.new(2, 'b', 3),
        FARule.new(3, 'a', 3), FARule.new(3, 'b', 3)
      ]

      @rulebook = DFARulebook.new(rules)
    end

    def test_accepting?
      assert { DFA.new(1, [1, 3], @rulebook).accepting? }
      refute { DFA.new(1, [2, 3], @rulebook).accepting? }
      assert { DFA.new(1, [1, 3], @rulebook).accepting? }
    end

    def test_read_character
      dfa = DFA.new(1, [3], @rulebook)
      assert { dfa.accepting? == false }

      dfa.read_character('b')
      assert { dfa.accepting? == false }

      3.times { dfa.read_character('a') }
      assert { dfa.accepting? == false }

      dfa.read_character('b')
      assert { dfa.accepting? }
    end
  end
end
