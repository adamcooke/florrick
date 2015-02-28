# This file contains all formatters which are built-in. Some of these built-in formatters
# require ActiveSupport but seeing as that's a dependency of ActiveRecord, it won't be a problem
# for most users.
require 'active_support/core_ext/integer/inflections'
require 'active_support/inflector/transliterate'
require 'digest/sha1'
require 'digest/md5'

#
# String formatters
#
Florrick::Formatter.add('downcase', [String]) { |s| s.downcase }
Florrick::Formatter.add('upcase', [String]) { |s| s.upcase }
Florrick::Formatter.add('humanize', [String]) { |s| s.humanize }
Florrick::Formatter.add('capitalize', [String]) { |s| s.capitalize }
Florrick::Formatter.add('strip', [String]) { |s| s.strip }
Florrick::Formatter.add('sha1', [String]) { |s| Digest::SHA1.hexdigest(s) }
Florrick::Formatter.add('md5', [String]) { |s| Digest::MD5.hexdigest(s) }

#
# Mathmatical formatters
#
Florrick::Formatter.add('double', [Numeric]) { |s| s * 2 }
Florrick::Formatter.add('triple', [Numeric]) { |s| s * 3 }

#
# Array formatters
#
Florrick::Formatter.add('join_with_commas', [Array]) { |a| a.join(', ')}
Florrick::Formatter.add('join_with_spaces', [Array]) { |a| a.join(' ') }
Florrick::Formatter.add('join_with_new_lines', [Array]) { |a| a.join("\n") }
Florrick::Formatter.add('as_list', [Array]) { |a| a.map { |v| "* #{v}"}.join("\n") }
Florrick::Formatter.add('to_sentence', [Array]) { |a| a.to_sentence }

#
# DateTime formatters
#

Florrick::Formatter.add('long_date', [Date, Time]) { |s| s.strftime("%A #{s.day.ordinalize} %B %Y") }
Florrick::Formatter.add('long_date_without_day_name', [Date, Time]) { |s| s.strftime("#{s.day.ordinalize} %B %Y") }

Florrick::Formatter.add('short_date', [Date, Time]) { |s| s.strftime("%a %e %b %Y") }
Florrick::Formatter.add('short_date_without_day_name', [Date, Time]) { |s| s.strftime("%e %b %Y") }

Florrick::Formatter.add('ddmmyyyy', [Date, Time]) { |s| s.strftime("%d/%m/%Y") }
Florrick::Formatter.add('hhmm', [Date, Time]) { |s| s.strftime("%H:%M") }
Florrick::Formatter.add('hhmmss', [Date, Time]) { |s| s.strftime("%H:%M:%S") }
Florrick::Formatter.add('hhmm12', [Date, Time]) { |s| s.strftime("%I:%M%P") }
Florrick::Formatter.add('hhmmss12', [Date, Time]) { |s| s.strftime("%I:%M:%S%P") }
