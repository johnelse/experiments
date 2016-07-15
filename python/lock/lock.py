#!/usr/bin/env python

import fcntl
import time

lock_path = "/var/lock/test.lock"

def acquire_lock(path):
    lock_file = open(path, "w")
    def acquire():
        print "attempting to acquire lock %s" % path
        try:
            fcntl.lockf(lock_file, fcntl.LOCK_EX | fcntl.LOCK_NB)
            return lock_file
        except IOError, e:
            print "could not acquire lock %s (%s) - waiting 1 second" % (path, e)
            time.sleep(1)
            acquire()
    acquire()

if __name__ == "__main__":
    lock_file = acquire_lock(lock_path)
    print "lock %s acquired - waiting 5 seconds." % lock_path
    time.sleep(5)
    print "done"
