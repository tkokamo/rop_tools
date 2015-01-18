#!/usr/bin/ruby
require 'open3'
require 'pp'

begin
  filename = ARGV[0]
  i = []
  File.open(filename, "rb") do |fp|
    blob = fp.read
    blob.scan(/\xc3/) do |elem|
      i << $~.offset(0)[0]
      #print elem + " " + i.to_s + "\n"   
    end
  end


  i.each do |i_elem|
    for j in 1..4 do 
      cmd = "objdump -M intel -D -b binary -m i386 #{filename} --start-address=%d --stop-address=%d| grep '^ '"%([(i_elem-j-1), (i_elem+1)])
      Open3.popen3(cmd) do |stdin, stdout, stderr|
        stdout.each do |line|
          if line.empty? || line.index('(bad)') || line.index('<internal disassembler error>') then
            next
          end
          print line
          #break
        end
        print "\n"
      #  break
      end
    end
  end

rescue Exception => e
  pp e.message
  pp e.backtrace
  exit 1
end

exit 0

