module PloggyConfigHelper

    def project_me
        'tca'
    end

    def project_persons
        {
            'tca' => 'Thom Castermans',
            'bsp' => 'Bettina Speckmann',
            'kve' => 'Kevin Verbeek',
            'jbr' => 'Jasper Brekelmans',
            'wso' => 'Willem Sonke'
        }
    end

    def project_name
        "Master's Project"
    end

    def project_start_date
        Date.parse('2015-02-02')
    end

    def project_end_date
        Date.parse('2015-06-26')
    end

    def project_hours_per_week
        40.hours # (30 ECTS * 28 hours) / 21 weeks = 40
    end


    def self.project_timezone
        '+01:00'
    end

end
