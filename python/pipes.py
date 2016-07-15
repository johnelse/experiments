#!/usr/bin/env python

import os, sys

print "I'm going to fork now - the child will write something to a pipe, and the parent will read it back"

r, w = os.pipe() # these are file descriptors, not file objects

pid = os.fork()
if pid:
  # we are the parent
  os.close(w) # use os.close() to close a file descriptor
  r = os.fdopen(r) # turn r into a file object
  print "parent: reading"
  txt = r.read()
  os.waitpid(pid, 0) # make sure the child process gets cleaned up
else:
  # we are the child
  os.close(r)
  w = os.fdopen(w, 'w')
  print "child: writing"
  w.write("here's some text from the child")
  w.close()
  print "child: closing"
  sys.exit(0)

print "parent: got it; text =", txt
