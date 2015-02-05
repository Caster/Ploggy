# Taken from https://github.com/blinry/blog-morr-cc and slightly modified.
class TidyFilter < Nanoc::Filter
    require "open3"
    identifier :tidy
    type :text

    def run(content, params={})
        Open3.popen3("tidy" +
                     " --quiet yes" +
                     " --char-encoding utf8" +
                     " --indent auto" +
                     " --indent-spaces 4" +
                     " --tidy-mark no" +
                     " --vertical-space no" +
                     " --wrap 0" +
                     " --show-warnings no") do |stdin, stdout, stderr, wait_thr|
            stdin.print content
            stdin.close

            ret = ""

            err = Thread.new do
                print stderr.readlines.join
            end
            out = Thread.new do
                ret = stdout.readlines.join
            end

            err.join
            out.join
            return ret
        end
    end
end
