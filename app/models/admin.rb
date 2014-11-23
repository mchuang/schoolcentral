# @author: elewis, jdefond

class Admin < ActiveRecord::Base
	#Admin has one user object, (as account)
	has_one :user, :as => :account, :dependent => :destroy

    has_many :events, :as => :owner, :dependent => :destroy

    alias_method :reminders, :events
    # Return an ActiveRecord::Relation containing all events related to this admin
    def events
        # Rewrote SQL in order to allow OR statement, other solutions?
        Event.where('(owner_id = :uid AND owner_type = :typ) OR classroom_id IN (:classes)',
            { uid: id, typ: "Admin", classes: user.school.classrooms.map(&:id) })
    end
end
