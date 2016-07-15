#!/usr/bin/env python

import getopt, sys

def main(config_dir, use_distfiles):
    print "config_dir = %s" % config_dir
    print "use_distfiles = %s" % use_distfiles

def usage():
    print "usage:"
    print "%s --config-dir=<config-dir> [--use-distfiles]" % sys.argv[0]

if __name__ == "__main__":
    config_dir = None
    use_distfiles = False
    try:
        opts, _ = getopt.getopt(sys.argv[1:], "", ["config-dir=", "use-distfiles"])
    except getopt.GetoptError, err:
        print str(err)
        usage()
        sys.exit(1)
    print "opts = %s" % opts
    print "args = %s" % args
    for o, a in opts:
        if o == "--config-dir":
            config_dir = a
        if o == "--use-distfiles":
            use_distfiles = True
    if config_dir == None:
        usage()
        sys.exit(1)
    main(config_dir, use_distfiles)
