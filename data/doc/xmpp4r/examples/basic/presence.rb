#!/usr/bin/ruby

# This bot will reply to every message it receives. To end the game, send 'exit'

$:.unshift '../../../../../lib'

require 'xmpp4r/client'
include Jabber

# settings
if ARGV.length != 2
  puts "Run with ./echo.rb user@server/resource password"
  exit 1
end
myJID = JID.new(ARGV[0])
myPassword = ARGV[1]
cl = Client.new(myJID)
cl.connect
cl.auth(myPassword)
puts "Authed ! Ready to presence!."
cl.send(Presence.new)
puts "Connected ! I am online "
sleep(10)
cl.close
puts "Closed ! I am offline "
