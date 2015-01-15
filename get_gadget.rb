#!/opt/rh/ruby193/root/usr/bin/ruby
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
      cmd = "objdump -M intel -D -b binary -m i386 #{filename} --start-address=%d --stop-address=%d| grep '^ '"%([(i_elem-j-1), (i_elem+2)])
      Open3.popen3(cmd) do |stdin, stdout, stderr|
        stdout.each do |line|
          print line
          break
        end
        break
      end
    end
  end

rescue Exception => e
  pp e.backtrace
  exit 1
end

exit 0

