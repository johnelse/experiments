# See http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/
# fs/naming_a_file.asp
forbiddenNames = ["CON", "PRN", "AUX", "NUL", "COM1", "COM2", "COM3", "COM4",
                  "COM5", "COM6", "COM7", "COM8", "COM9", "LPT1", "LPT2",
                  "LPT3", "LPT4", "LPT5", "LPT6", "LPT7", "LPT8", "LPT9"]
excludedChars = ['<', '>', ':', '"', '/', '\\', '|', '?', '*', '(', ')']

def SanitizeVMNameForWindows(name):
    try:
        # Don't allow empty filename
        if len(name) == 0:
            return '_'

        newname = ''

        # Allow only 31 < c < 126, excluding  < > : " / \ | ? *
        for c in name:
            if (ord(c) > 31 and ord(c) < 127 and
                    c != ' ' and not IsCharExcluded(c)):
                newname += c
            else:
                newname += '_'

        # Make sure the name does not start with a Windows forbidden name
        for forbidden in forbiddenNames:
            # Names can't be any of com1, com2, or com1.xyz, com2.abc etc.
            if newname == forbidden or newname.startswith(forbidden):
                newname = "_" + newname;

        return newname

    except Exception, e:
        print("Exception in SanitizeVMNameForWindows: %s" % str(e))
        return ''

def IsCharExcluded(c):
    for excluded in excludedChars:
        if c == excluded:
            return True
    return False

def make_string(length):
    return "x" * length

def test_string(length):
    string = make_string(length)
    SanitizeVMNameForWindows(string)
