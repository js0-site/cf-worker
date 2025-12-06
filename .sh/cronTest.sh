#!/usr/bin/expect

set retries 0
while {[catch {exec lsof -ti:9229} pid] == 0 && $retries < 10} {
  puts "Port 9229 is busy (PID: $pid). Killing... ($retries)"
  catch {exec sh -c "lsof -ti:9229 | xargs kill -9"}
  sleep 0.5
  incr retries
}
sleep 1
spawn bun dev
expect "Ready"
puts [exec curl -s http://localhost:8787/__scheduled]
send \003
expect eof
