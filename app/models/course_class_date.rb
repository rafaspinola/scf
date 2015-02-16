class CourseClassDate < ActiveRecord::Base
  belongs_to :course_class

  def to_s
    self.day.year == Date.today.year ? self.day.strftime("%d/%m") : self.day.strftime("%d/%m/%Y")
  end

  def self.get_dates(start_date, end_date)
  	all_dates = [start_date]
  	t = start_date + 1.day
  	while t <= end_date
  		all_dates << t
  		t = t + 1.day
  	end
  	all_dates
  end

  def self.get_calendar(start_date, end_date)
  	all_dates = get_dates(start_date, end_date)
  	calendar = []
  	week = []
  	all_dates.each do |date|
  		week[date.wday] = date
  		if date.wday == 6 then
  			calendar << week
  			week = []
  		end
  	end
  	calendar << week
  	calendar
  end

  def self.get_dates_from_list(list)
    converted_dates = []
    dates = list.scan(/(\d+)\/(\d+)(\/(\d+))?/)
    dates.each do |d|
      year = ((d[3] != nil) && d[3].to_i) || Date.today.year
      month = d[1].to_i
      day = d[0].to_i
      converted_dates << Date.new(year, month, day) unless (year == 0 || month == 0 ||day == 0)
    end
    converted_dates
  end
end