module PloggyConfigHelper

    def project_me
        # nick of yourself
        'tca'
    end

    def project_persons
        # this is a hash of persons involved in the project, the keys are nicks
        # you can use in your log entries, the full names are shown on the page
        {
            'tca' => 'Thom Castermans',
            'plo' => 'Ploggy Logger'
        }
    end

    def project_name
        "Ploggy Log"
    end

    def project_start_date
        # fill in the start date of your project
        Date.parse('2015-02-02')
    end

    def project_end_date
        # fill in the end date of your project
        Date.parse('2015-02-11')
    end

    def project_days_per_week
        # fill in the number of days per week you work on your project
        5.days
    end

    def project_hours_per_day
        # fill in the number of hours per day you work on your project
        8.hours
    end


    def self.project_timezone
        # change this to whatever your timezone is, but keep the format
        '+01:00'
    end

end
