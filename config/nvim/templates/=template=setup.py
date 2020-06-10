#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © %YEAR% %USER% <%MAIL%>
#
# Distributed under terms of the %LICENSE% license.

"""
%HERE%
"""

from setuptools import find_packages, setup

setup(
    name='%DIRECTORY%',
    use_scm_version={'version_scheme': 'post-release'},
    python_requires='>=3.6',
    setup_requires=['setuptools_scm'],
    install_requires=[],
    packages=find_packages('src'),
    package_dir={'': 'src'},
    include_package_data=True,
    entry_points="""
        [console_scripts]
    """,
    url='',
    author='%USER%',
    author_email='%MAIL%',
    description='',
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Environment :: Console',
        'Intended Audience :: Developers',
        'Intended Audience :: Science/Research',
        'License :: OSI Approved :: MIT License',
        'Operating System :: MacOS :: MacOS X',
        'Operating System :: POSIX :: Linux',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.6',
    ],
)
