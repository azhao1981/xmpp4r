#!/usr/bin/ruby
#
# XMPP4R - XMPP Library for Ruby
# Copyright (C) 2005 Stephan Maka <stephan@spaceboyz.net>
# Released under Ruby's license (see the LICENSE file) or GPL, at your option
#
#
# Roster-Add example
#
#
# Learn how to subscript a user presence
$:.unshift '../../../../../lib/'

require 'xmpp4r'
require 'xmpp4r/roster/helper/roster'

# Command line argument checking
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

if ARGV.size != 3
  puts("Usage: ./rosterregadd.rb <jid> <password> <tojid>")
  exit
end

jid,pwd,to_jid = ARGV
regitser_add_roster(jid,pwd,to_jid)
