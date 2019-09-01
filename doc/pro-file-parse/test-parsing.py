#!/bin/python

with open("./Sailing.pro", "r") as fp:
    for line in fp:
        if (line == "SUBDIRS"):
            print 1
