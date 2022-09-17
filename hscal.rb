#!/usr/bin/env ruby
require 'date'

HS = ['甲寅','乙卯','丙辰','丁巳','戊午','己未','庚申','辛酉','壬戌','癸亥',
      '甲子','乙丑','丙寅','丁卯','戊辰','己巳','庚午','辛未','壬申','癸酉',
      '甲戌','乙亥','丙子','丁丑','戊寅','己卯','庚辰','辛巳','壬午','癸未',
      '甲申','乙酉','丙戌','丁亥','戊子','己丑','庚寅','辛卯','壬辰','癸巳',
      '甲午','乙未','丙申','丁酉','戊戌','己亥','庚子','辛丑','壬寅','癸卯',
      '甲辰','乙巳','丙午','丁未','戊申','己酉','庚戌','辛亥','壬子','癸丑']

if ARGV.size == 0
  date = Date.today
elsif ARGV[0] =~ /^(\d+)$/
  date = Date.parse("#{$1}-01-01")
elsif ARGV[0] =~ /^(\d+)-([1-9]|0[1-9]|1[0-2])$/
  date = Date.parse("#{$1}-#{$2}-01")
elsif ARGV[0] =~ /^(\d+)-([1-9]|0[1-9]|1[0-2])-([1-9]|0[1-9]|1[0-9]|2[0-9]|3[01])$/
  date = Date.parse("#{$1}-#{$2}-#{$3}")
else
  puts "invalid argument"
  exit(0)
end

day   = date.day
month = date.month
year  = date.year
lastday = Date.new(year, month, -1).day

if month == 1
  month = 13
  year -= 1
elsif month == 2
  month = 14
  year -= 1
else
  #pass
end

mjd = ( 365.25 * year.to_f ).to_i + ( year.to_f / 400.to_f ).to_i - ( year.to_f / 100.to_f ).to_i + ( 30.59 * ( month.to_f - 2.to_f ) ).to_i + 1 - 678912

month = date.month
year  = date.year
printf "%d年%2d月\n", year, month

puts "Sun    Mon    Tue    Wed    Thu    Fri    Sat    "

cwday = mjd % 7
i = cwday

while i % 7 != 4
  print "       "
  i -= 1
end

(1..lastday).each do |d|

  printf "%2d%s ", d, HS[ ( mjd + d - 1 ) % 60 ]

  if cwday % 7 == 3
    print "\n"
  end
  cwday += 1

end

print "\n"
