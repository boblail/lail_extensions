module DateExtensions
  

 
  def months_since(earlier_date)
    ((self.year - earlier_date.year) * 12) + (self.month - earlier_date.month).to_int
  end
  
  def weeks_since(earlier_date)
    ((self.at_beginning_of_week - earlier_date.to_date.at_beginning_of_week) / 7).to_int
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
  
    def Date.months_between(date1, date2)
      (date1 > date2) ? (later_date, earlier_date = date1, date2) : (later_date, earlier_date = date2, date1)
      later_date.months_since(earlier_date)
    end
    
    def Date.weeks_between(date1, date2)
      (date1 > date2) ? (later_date, earlier_date = date1, date2) : (later_date, earlier_date = date2, date1)
      later_date.weeks_since(earlier_date)
    end
    
    def Date.years_between(date1, date2)
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