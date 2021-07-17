require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

def clean_zipcode(zipcode)
#   if zipcode.nil?
#     '00000'
#   elsif zipcode.length < 5
#     zipcode.rjust(5, '0')
#   elsif zipcode.length > 5
#     zipcode[0..5]
#   else
#     zipcode
#   end
  zipcode.to_s.rjust(5, '0')[0..5]
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials
    legislator_names = legislators.map(&:name)
    legislator_names.join(', ')
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exists?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone_number(num)
  begin
    num = num.delete('^0-9')
    if num.length < 10 || num.length > 11 || (num.length == 11 && num[0] != '1')
      'Invalid Number'
    else
      num[-10..-1]
    end
  rescue
    'Invalid Number'
  end
end

puts 'EventManager Initialized!'

# contents = File.read('event_attendees.csv')
# puts contents

# lines = File.readlines('event_attendees.csv')
# lines.each_with_index do |line, index|
#   next if index == 0
#   columns = line.split(',')
#   name = columns[2]
#   puts name
# end

contents = CSV.open('lib/event_attendees.csv', headers: true, header_converters: :symbol)
template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

arr_hours = []
i = 0
while i < 24 do
  arr_hours.push([0, i])
  i += 1
end

arr_days = []
i = 0
while i < 7 do
  arr_days.push([0, i])
  i += 1
end

contents.each do |row|
  id=row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  number = clean_phone_number(row[:homephone])
  date = DateTime.strptime(row[:regdate], "%m/%d/%y %H:%M")
  arr_hours[date.hour][0] += 1
  arr_days[date.wday][0] += 1
#   if zipcode == nil
#     zipcode = '00000'
#   elsif zipcode.length < 5
#     zipcode = zipcode.rjust(5, '0')
#   elsif zipcode.length > 5
#     zipcode = zipcode[0..4]
#   end

  legislators = legislators_by_zipcode(zipcode)
#   puts "#{name} #{zipcode} #{legislators}"

#   personal_letter = template_letter.gsub('FIRST_NAME', name)
#   personal_letter.gsub!('LEGISLATORS', legislators)
#   puts form_letter

  form_letter = erb_template.result(binding)
#   puts form_letter

  save_thank_you_letter(id, form_letter)
  puts "Number: #{number}"
end

arr_hours.sort!
puts("\nHours of the day sorted by number of registrations: ")
arr_hours.reverse_each { |a| puts("#{a[1]}H: #{a[0]} people") }

days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
arr_days.sort!
puts("\nDays of the week sorted by number of registrations: ")
arr_days.reverse_each { |a| puts("#{days[a[1]]}: #{a[0]} people")}
