class CourseClass < ActiveRecord::Base
  belongs_to :course
  belongs_to :result_center
  has_many :course_class_dates
  has_many :subscriptions
  has_and_belongs_to_many :trainers

  after_create :set_dates
  after_update :update_dates

  attr_accessor :date_list

  scope :future, -> { 
    min_dates_sql = CourseClassDate.select("course_class_id, MIN(day) AS day").group("course_class_id").to_sql
    today = Date.today.strftime("%Y-%m-%d")
    joins("INNER JOIN (#{min_dates_sql}) a ON course_class_id = id").where("a.day >= '#{today}'")

  }

  # CourseClass.find_by_sql("SELECT * FROM course_classes WHERE id IN (SELECT course_class_id FROM (SELECT course_class_id, MIN(day) AS begin_date FROM course_class_dates GROUP BY course_class_id) a WHERE begin_date >= '" + Date.today.strftime("%Y-%m-%d") + "')")

  validates_presence_of :course, :city, :address

  def to_s
    "#{self.course.code} - #{self.city} - #{self.identifier}"
  end

  def begin_date
    self.course_class_dates.first
  end

  def trainer_names
    self.trainers.join ", "
  end

  def class_dates
    self.course_class_dates.join " "
  end

  def class_times
    self.start_time.strftime("%H:%M") + " às " + self.end_time.strftime("%H:%M")
  end

  def set_dates
    create_course_class_dates(CourseClassDate.get_dates_from_list(self.date_list))
  end

  def update_dates
    self.course_class_dates.clear
    create_course_class_dates(CourseClassDate.get_dates_from_list(self.date_list))   
  end

  protected

  def create_course_class_dates(dates)
    dates.each do |d|
      self.course_class_dates << CourseClassDate.new(day: d)
    end
  end

end
