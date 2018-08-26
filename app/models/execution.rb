class Execution < ApplicationRecord
  def self.latest
    Execution.all.limit(100)
  end
end
