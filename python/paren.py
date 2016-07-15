#!/usr/bin/env python

import sys

def check(s):
  level = 0
  for c in s:
    if c == "(":
      level += 1
    elif c == ")":
      level -= 1
    if level < 0:
      return False
  return (level == 0)

print check(sys.argv[1])
