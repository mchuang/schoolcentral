class Event < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true

  belongs_to :classroom

  def self.get_date_range(account, start_d, end_d)
    account.events.where(
        '(startime BETWEEN :st AND :ed) OR (endtime BETWEEN :st AND :ed)',
        { st: start_d, ed: end_d }
    ).order('startime')
  end

  def self.get_day(account, date)
    get_date_range(account, date.beginning_of_day, date.end_of_day)
  end

  def self.get_week(account, date)
    get_date_range(account, date.beginning_of_week, date.end_of_week)
  end

  def self.get_month(account, date)
    get_date_range(account, date.beginning_of_month, date.end_of_month)
  end
end
