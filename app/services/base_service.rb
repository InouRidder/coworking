# frozen_literal_string: true

class BaseService
  class << self
    def call(*args)
      new(*args).call
    end
  end
end
