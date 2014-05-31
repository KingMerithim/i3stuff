#!/usr/bin/ruby

a = `free | grep "Mem:"`

#puts a
a = /(?<mem>[\w]+):\s+(?<total>[\d]+)\s+(?<used>[\d]+)\s+(?<free>[\d]+)/.match a

#puts b
#puts a[:mem], a[:total], a[:used], a[:free]

b = '%.2f' % ((100/Float(a[:total]))*Float(a[:used]))
puts b
