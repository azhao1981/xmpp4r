#!/usr/bin/ruby

$:.unshift '../../../../../lib'
require 'xmpp4r'
require 'xmpp4r/roster/helper/roster'

# Argument checking
if ARGV.size < 2
  puts("Usage: #{$0} <desired jid> <password> [field1=value1] [fieldN=valueN]")
  exit
end
to_jid = ARGV[0]
jid = ARGV[0]
pwd = ARGV[1]
# The usual procedure
def regitser_add_roster(jid, pwd, to_jid)
  cl = Jabber::Client.new(Jabber::JID.new(jid))
  cl.connect

  # Registration of the new user account
  puts "Registering... "

  begin
    fields = { 'name' => jid }
    
    cl.register(pwd, fields)
    puts "Successful"
  rescue Jabber::ServerError => e
    puts "Error: #{e.error.text}"
    if e.error.type == :modify
      puts "Accepted registration information:"
      instructions, fields = cl.register_info
      fields.each { |info|
        puts "* #{info}"
      }
      puts "(#{instructions})"
    end
  end
  cl.auth(pwd)
  roster = Jabber::Roster::Helper.new(cl)
  puts "add #{to_jid} to roster"
  roster.add(to_jid,nil,true)
  cl.close
end
10.times do |i|
  tmp = sprintf("%.4d",i)
  regitser_add_roster("4#{tmp}_#{jid}",'123', to_jid)
end

