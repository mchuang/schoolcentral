class Event < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true

  belongs_to :classroom
end
