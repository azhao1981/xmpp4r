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
require 'xmpp4r/vcard/helper/vcard'

# Command line argument checking

if ARGV.size != 3
  puts("Usage: ./rosteradd.rb <jid> <password> <tojid>")
  exit
end

#Jabber::debug = true

jid = Jabber::JID.new(ARGV[0])

cl = Jabber::Client.new(jid)
cl.connect
cl.auth(ARGV[1])

# The roster instance
roster = Jabber::Roster::Helper.new(cl)
roster.add(ARGV[2],nil,true)


cl.close
