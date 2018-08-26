class ExecutionsController < ApplicationController
  def show
    @executions = Execution.latest
  end
end
