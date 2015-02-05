require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'helpers', 'ploggy_config.rb'))

usage       'addlog [start] [end] [description] [category]'
aliases     :al
summary     'create a new log entry'
description 'This command can create a new log entry with a given time, today, and some other stuff.'

flag   :h, :help,  'show help for this command' do |value, cmd|
    puts cmd.help
    exit 0
end
required :s, :start, 'start time of entry (today), must be given as HH:MM'
optional :e, :end, 'end time of entry (today), must be given as HH:MM'
optional :c, :category, 'category of entry'

run do |opts, args, cmd|
    arg_i = 0
    # is start given as argument?
    if args.length > arg_i and not opts[:start]
        opts[:start] = args[arg_i]
        arg_i += 1
    end
    # is end given as argument?
    if args.length > arg_i and not opts[:end]
        opts[:end] = args[arg_i]
        arg_i += 1
    end
    # is description given?
    if args.length > arg_i
        description = args[arg_i]
        arg_i += 1
    else
        description = 'TODO: write a description.'
    end
    # is category given as argument?
    if args.length > arg_i and not opts[:category]
        opts[:category] = args[arg_i]
        arg_i += 1
    end

    # if start is missing, we quit, because it is required
    if not opts[:start]
        puts 'The start option is required.'
        exit 1
    end

    # convert start and end times to timestamps including date (today)
    start_t = today_time(opts[:start])
    end_t = (opts[:end]) ? today_time(opts[:end]) : nil
    # default category is work
    category = (opts[:category]) ? opts[:category] : 'work'

    # read current log files to determine number of next one
    cur_dir = File.expand_path(File.dirname(__FILE__))
    logs = Dir[cur_dir.to_s + '/../content/logs/*.md']
    max_log = -1
    logs.each{|log| max_log = [max_log, /\/(\d+)\.md$/.match(log)[1].to_i].max}

    # write to new log file
    new_log_path = cur_dir.to_s + '/../content/logs/' + (max_log + 1).to_s + '.md'
    File.open(new_log_path, 'w') { |file|
        file.write("---\n")
        file.write('start_time: "' + start_t + "\"\n")
        if end_t != nil
            file.write('end_time:   "' + end_t + "\"\n")
        end
        file.write('category:   "' + category + "\"\n")
        file.write("---\n")
        file.write(description + "\n")
    }
end

# Construct a timestamp from a 'HH:MM' string, appending today as a date and the
# timezone from the PloggyConfigHelper module.
def today_time(time_s)
    time_hash = Date._strptime(time_s, '%H:%M')
    Date.today.strftime('%Y-%m-%dT') +
            DateTime.new(1, 1, 1, time_hash[:hour], time_hash[:min], 0).
            strftime('%H:%M:%S') + PloggyConfigHelper::project_timezone
end
