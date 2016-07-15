#!/usr/bin/python
from multiprocessing import Pipe, Process
import os
import sys

def get_child_count():
  try:
    child_count = int(sys.argv[1])
  except Exception:
    print "Could not read argument - creating 1 child."
    child_count = 1
  return child_count

def child(fd):
  i = 0
  while not fd.poll():
    i += 1
    if i % 1000000 == 0:
      print "Process %d says hi." % os.getpid()
      i = 0
  fd.close()

child_count = get_child_count()
pipes = []

# Create child processes.
for i in range(child_count):
  (recv,send) = Pipe(False)
  pipes.append(send)
  proc = Process(target=child, args=(recv,))
  proc.start()
  print "child %d created" % i

# Wait for user input.
raw_input("Press return to quit.")

# Send signal to all pipes and close them.
for pipe in pipes:
  pipe.send("x")
  pipe.close()

print "Finished."
