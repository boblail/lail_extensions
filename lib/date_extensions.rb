<<<<<<< HEAD:lib/date_extensions.rb
module DateExtensions
  
  
  def last_sunday
    case self.wday
    when 0 then self
    when 1 then 1.day.ago(self)
    else        1.day.ago(self.at_beginning_of_week)
    end
  end

 
  def months_since(earlier_date)
    ((self.year - earlier_date.year) * 12) + (self.month - earlier_date.month).to_int
  end
  
  def weeks_since(earlier_date)
    ((self.to_date.last_sunday - earlier_date.to_date.last_sunday) / 7).to_int
  end
  
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
  
    def self.months_between(date1, date2)
      (date1 > date2) ? (later_date, earlier_date = date1, date2) : (later_date, earlier_date = date2, date1)
      later_date.months_since(earlier_date)
    end
    
    def self.weeks_between(date1, date2)
      (date1 > date2) ? (later_date, earlier_date = date1, date2) : (later_date, earlier_date = date2, date1)
      later_date.weeks_since(earlier_date)
    end
    
    def self.years_between(date1, date2)
      (date1 > date2) ? (later_date, earlier_date = date1, date2) : (later_date, earlier_date = date2, date1)
      later_date.years_since(earlier_date)
    end
    
  end  
  
  
  
  def self.included(other_module)
    other_module.extend ClassMethods
  end
  
end


Date.send :include, DateExtensions
DateTime.send :include, DateExtensions