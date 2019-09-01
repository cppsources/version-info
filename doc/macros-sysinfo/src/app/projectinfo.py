#!/bin/python

def parse_project_version(version, param = ""):
    temp = version.split("_")[1]

    if param == "app_name":
        return version.split("_")[0]
    elif param == "build_year":
        return temp.split("~")[0].split(".")[0]
    elif param == "build_month":
        return temp.split("~")[0].split(".")[1]
    elif param == "build_day":
        return temp.split("~")[0].split(".")[2]
    elif param == "build_number":
        return temp.split("~")[0].split(".")[3]
    elif param == "desc":
        return temp.split("~")[1]
    elif param == "arch":
        return version.split("_")[2]
    elif param == "os":
        return version.split("_")[3]

    return version

#def get_app_version(version_filename):
    #file = open(version_filename, "r")
    #lines = file.readlines()

    #items = {}
    #for line in lines:
        #key_value = line.split("=")
        #items[key_value[0].strip()] = key_value[1].strip()
    #return items["project_version"]

#def parse_app_version(version, param = ""):
    #temp = version.split("_")[1]

    #if param == "app_name":
        #return version.split("_")[0]
    #elif param == "build_year":
        #return temp.split("~")[0].split(".")[0]
    #elif param == "build_month":
        #return temp.split("~")[0].split(".")[1]
    #elif param == "build_day":
        #return temp.split("~")[0].split(".")[2]
    #elif param == "build_number":
        #return temp.split("~")[0].split(".")[3]
    #elif param == "desc":
        #return temp.split("~")[1]
    #elif param == "arch":
        #return version.split("_")[2]
    #elif param == "os":
        #return version.split("_")[3]
    #return version

#def parse_plugin_version(version, param = ""):
    #return version
