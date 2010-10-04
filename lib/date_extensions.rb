module DateExtensions
  
  
  def last_sunday
    case self.wday
    when 0 then self
    when 1 then 1.day.ago(self)
    else        1.day.ago(self.at_beginning_of_week)
    end
  end
  
  
  def whole_months_since(earlier_date)
    whole_months = self.at_beginning_of_month.months_since(1.month.after(earlier_date.at_beginning_of_month))
    whole_months += 1 if (self.day == Date.new(self.year, self.month, -1).day)
    whole_months += 1 if (earlier_date.day == 1)
    whole_months
    # ((self.year - earlier_date.year) * 12) + (self.month - earlier_date.month).to_int
  end
  
  def months_since(earlier_date)
    ((self.year - earlier_date.year) * 12) + (self.month - earlier_date.month).to_int
  end
  
  def sundays_since(earlier_date)
    ((self.to_date.last_sunday - earlier_date.to_date.last_sunday) / 7).to_int
  end
  alias :weeks_since :sundays_since
  
  def years_since(earlier_date)
    (self.year - earlier_date.year)
  end
  


  def months_until(later_date)
    later_date.months_since(self)
  end
  
  def weeks_until(later_date)
    later_date.weeks_since(self)
  end
  
  def years_until(later_date)
    later_date.years_since(self)
  end
  


  module ClassMethods
  
    def whole_months_between(date1, date2)
      later_date, earlier_date = sort_dates(date1, date2)
      later_date.whole_months_since(earlier_date)
    end
  
    def months_between(date1, date2)
      later_date, earlier_date = sort_dates(date1, date2)
      later_date.months_since(earlier_date)
    end
    
    def weeks_between(date1, date2)
      later_date, earlier_date = sort_dates(date1, date2)
      later_date.weeks_since(earlier_date)
    end
    
    def years_between(date1, date2)
      later_date, earlier_date = sort_dates(date1, date2)
      later_date.years_since(earlier_date)
    end
    
  private
    
    def sort_dates(date1, date2)
      (date1 > date2) ? [date1, date2] : [date2, date1]
    end
    
  end  
  
  
  
  def DateExtensions.included(other_module)
    other_module.send :extend, ClassMethods    
  end
  
end


Date.send :include, DateExtensions
DateTime.send :include, DateExtensions