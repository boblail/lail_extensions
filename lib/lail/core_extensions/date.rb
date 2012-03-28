require 'active_support/all'
require 'lail/core_extensions/duration'

module Lail
  module CoreExtensions
    module Date
      
      
      
      def last_sunday
        # This is utterly ridiculous.
        #
        # For some reason when running _migrations_,
        # 1.day.ago(self) returns a date 236 years
        # in the past.
        #
        # For Date and DateTime objects, - 1
        # subtracts 1 day and works in this strange
        # situation.
        #
        case self.wday
        when 0 then self
        when 1 then self - 1 # 1.day.ago(self)
        else        self.beginning_of_week - 1 # 1.day.ago(self.at_beginning_of_week)
        end
      end
      
      def next_sunday
        self.last_sunday + 7
      end
      
      
      
      def get_whole_months_since(earlier_date)
        earlier_date = 1.month.after(earlier_date.at_beginning_of_month) unless earlier_date.at_beginning_of_month?
        later_date = self.at_end_of_month? ? 1.month.after(self.at_beginning_of_month) : self.at_beginning_of_month
        whole_months = later_date.get_months_since(earlier_date)
        (whole_months < 0) ? 0 : whole_months
      end
      alias :whole_months_since :get_whole_months_since
      
      def get_months_since(earlier_date)
        ((self.year - earlier_date.year) * 12) + (self.month - earlier_date.month).to_int
      end
      
      def get_sundays_since(earlier_date)
        ((self.to_date.last_sunday - earlier_date.to_date.last_sunday) / 7).to_int
      end
      alias :sundays_since :get_sundays_since
      alias :get_weeks_since :get_sundays_since
      
      def get_years_since(earlier_date)
        (self.year - earlier_date.year)
      end
      
      
      
      def get_months_until(later_date)
        later_date.months_since(self)
      end
      
      def get_weeks_until(later_date)
        later_date.weeks_since(self)
      end
      
      def get_years_until(later_date)
        later_date.years_since(self)
      end
      
      
      
      def at_beginning_of_month?
        self.day == 1
      end
      alias :beginning_of_month? :at_beginning_of_month?
      
      def at_end_of_month?
        self.day == self.end_of_month.day
      end
      alias :end_of_month? :at_end_of_month?
      
      
      
      module ClassMethods
        
        def can_parse?(string)
          begin
            parse(string)
            true
          rescue
            false
          end
        end
        
        def whole_months_between(date1, date2)
          later_date, earlier_date = sort_dates(date1, date2)
          later_date.get_whole_months_since(earlier_date)
        end
        
        def months_between(date1, date2)
          later_date, earlier_date = sort_dates(date1, date2)
          later_date.get_months_since(earlier_date)
        end
        
        def weeks_between(date1, date2)
          later_date, earlier_date = sort_dates(date1, date2)
          later_date.get_weeks_since(earlier_date)
        end
        
        def years_between(date1, date2)
          later_date, earlier_date = sort_dates(date1, date2)
          later_date.get_years_since(earlier_date)
        end
        
      private
        
        def sort_dates(date1, date2)
          (date1 > date2) ? [date1, date2] : [date2, date1]
        end
        
      end
      
      
      
      def Date.included(other_module)
        other_module.send :extend, ClassMethods    
      end
      
      
      
    end
  end
end

Date.send     :include, Lail::CoreExtensions::Date
DateTime.send :include, Lail::CoreExtensions::Date
