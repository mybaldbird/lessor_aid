class User < ApplicationRecord
  def as_json(options)
    super only: [:id, :name]
  end
end
