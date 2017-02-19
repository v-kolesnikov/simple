require 'irb'

module Simple
  module Repl
    def self.start
      IRB.setup(eval('__FILE__'))
      IRB::Irb.new(IRB::WorkSpace.new(Simple)).run(IRB.conf)
    end
  end
end
