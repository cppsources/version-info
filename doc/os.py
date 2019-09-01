#!/bin/python

import os

def get_os_version():
    os_version = "n/a"
    if os.name == "posix":
        str = os.popen('uname -a').read();
        if str.find("Debian") != -1:
            os_version = "DEBIAN"
        elif str.find("vniins") != -1:
            os_version = "MSVS"
        elif str.find("Ubuntu") != -1:
            os_version = "UBUNTU"
        elif str.find("astra-linux") != -1:
            os_version = "ASTRA"
    # TODO: add Windows support

    return os_version

print get_os_version()
