class User < ApplicationRecord
  has_many :updates

  def get_update
    update = updates.active.last

    return updates.build unless update

    update
  end
end
