#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2017 Malcolm Ramsay <malramsay64@gmail.com>
#
# Distributed under terms of the MIT license.

"""Setup for cphd."""

from setuptools import setup


setup(
    name='cphd',
    version='0.1',
    py_modules=['cphd'],
    install_requires=[
        'Click',
        'dateparser',
    ],
    entry_points='''
        [console_scripts]
        cphd=cphd:cphd
    ''',
)
