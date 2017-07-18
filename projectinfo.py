#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os

# @brief get_project_name возвращает имя проекта (имя в верхнем регистре и соответствует макросу)
# @desc в основе имя главного pro-файла проекта
# @param pro_file_path путь к главному pro-файлу проекта
def get_project_name(pro_file_path):
    basename = os.path.basename(pro_file_path)
    project_name = os.path.splitext(basename)[0]
    project_name = project_name.upper()
    project_name = project_name.replace("-", "_") # для соответствия макросу
    return project_name

# @brief get_project_version возвращает часть версии проекта
# @param version версия проекта, заданная в виде строки:
# {major}.{minor}.{patch}.{build}
# @param param часть версии проекта, которую необходимо вернуть. Допустимые
# значения: major, minor, patch, build
# @return в зависимости от param, если param не задано или не существует, то
# сообщение об ошибке
def get_project_version(version, param):
    items = version.split(".")

    if param == "major":
        return items[0]
    elif param == "minor":
        return items[1]
    elif param == "patch":
        return items[2]
    elif param == "build":
        return items[3]
    else: # если несуществующий аргумент
        assert False # TODO: реализовать обработку ошибки

# @brief get_project_build_info возвращает часть информации о сборке проекта
# @param build_info информация о сборке проекта, заданная в виде строки:
# {build_datetime}.{build_number}~{build_desc}
# @param $${2} часть версии проекта, которую необходимо вернуть. Допустимые
# значения: build_datetime, build_number, build_desc
# @return в зависимости от param, если param не задано или не существует то
# сообщение об ошибке
def get_project_build_info(build_info, param):

    if param == "build_datetime":
        return build_info.split(".")[0]
    elif param == "build_number":
        return build_info.split(".")[1].split("~")[0]
    elif param == "build_desc":
        return build_info.split(".")[1].split("~")[1]
    else: # если несуществующий аргумент
        assert False # TODO: реализовать обработку ошибки
