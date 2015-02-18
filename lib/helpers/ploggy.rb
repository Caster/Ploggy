module PloggyHelper

    @log_items = []
    @use_project_time = false

    def self.log_items
        @log_items
    end

    def self.log_time
        total_time_s = 0
        @log_items.each{ |item|
            start_time = DateTime.parse(item[:start_time])
            end_time = (item[:end_time] == nil) ? start_time : DateTime.parse(item[:end_time])
            spent_diff = end_time - start_time

            total_time_s += spent_diff * 24 * 60 * 60
        }
        total_time_s
    end

    def self.sort_log_items
        @log_items.sort! {|x, y| DateTime.parse(x[:start_time]) <=> DateTime.parse(y[:start_time])}
    end

    def self.sup_fix(num)
        if num == 1
            'st'
        elsif num == 2
            'nd'
        elsif num == 3
            'rd'
        else
            'th'
        end
    end

    def self.time_to_s(time)
        time = time.to_i
        time_names = ['week', 'day', 'hour', 'minute', 'second']
        time_values = [1.week, 1.day, 1.hour, 1.minute, 1.second]
        time_split = [0, 0, 0, 0, 0]

        # build an array with different time formats
        while time > 0
            time_split.length.times do |i|
                if time >= time_values[i]
                    time -= time_values[i]
                    time_split[i] += 1
                    break
                end
            end
        end

        # build string out of array
        time_a = []
        time_split.length.times do |i|
            if time_split[i] > 0
                time_s = time_split[i].to_s + ' ' + time_names[i]
                if time_split[i] != 1
                    time_s += 's'
                end
                time_a.push(time_s)
            end
        end
        if time_a.length == 0
            ''
        elsif time_a.length == 1
            time_a[0]
        else
            time_a[0..-2].join(', ') + ' and ' + time_a[-1]
        end
    end

    def self.use_project_time!(upt = true)
        @use_project_time = upt
    end

    def self.use_project_time?
        @use_project_time
    end

    def self.work_time(start_date, end_date)
        start_date.step(end_date).select{|d| !d.saturday? && !d.sunday?}.size
    end

end

# extend Fixnum
class Fixnum

    def seconds
        self
    end
    alias :second :seconds

    def minutes
        self * 60.seconds
    end
    alias :minute :minutes

    def hours
        self * 60.minutes
    end
    alias :hour :hours

    def days
        self * (PloggyHelper.use_project_time? ? PloggyConfigHelper.project_hours_per_day : 24.hours)
    end
    alias :day :days

    def weeks
        self * (PloggyHelper.use_project_time? ? PloggyConfigHelper.project_days_per_week : 7.days)
    end
    alias :week :weeks

end
