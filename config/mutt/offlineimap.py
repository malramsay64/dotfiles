#! /usr/bin/env python2
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2018 Malcolm Ramsay <malramsay64@gmail.com>
#
# Distributed under terms of the MIT license.

from subprocess import check_output

def get_pass(account):
    return check_output("pass show mail/{}".format(account), shell=True).strip(" \n")
