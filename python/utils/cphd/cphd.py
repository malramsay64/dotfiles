#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2017 Malcolm Ramsay <malramsay64@gmail.com>
#
# Distributed under terms of the MIT license.

"""Copy for PhD.

A shell script that copies a file to my PhD logbook with an appropriate
filename and description, long with adding an entry into my logbook for
the day.
"""

from pathlib import Path
from shutil import copy
import logging

import click
import dateparser

LOGBOOK = Path.home() / 'Documents/notes/PhD/logbook'
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)


def _parse_date(ctx, param, date_string):
    logger.debug(f'ctx: {ctx}, param: {param}, date_string: {date_string}')
    try:
        date = dateparser.parse(date_string).date()
        logger.debug(f'Converted date: {date}')
        return date
    except ValueError:
        raise click.BadParameter('Date not understandable by parser')


def _add2logbook(date, dest, long_desc):
    logbook_entry = LOGBOOK / f'{date}.wiki'
    with open(logbook_entry, 'a') as logbook:
        logbook.write('\n{{' + f'file:{dest}|{long_desc}' + '}}\n')


def _verbosity(ctx, param, count):
    if count:
        logging.basicConfig(level=logging.DEBUG)


@click.command()
@click.argument('filename', type=click.Path(exists=True))
@click.option('--short-desc', prompt='Short Description for filename',
              help='Description to put into filename')
@click.option('--long-desc', prompt='Long description for caption',
              help='Description for caption')
@click.option('-v', '--verbose', count=True, callback=_verbosity,
              expose_value=False, help='Ouptut debug logs')
@click.option('--date', callback=_parse_date, default='today',
              help='Date for which image should be added')
def cphd(filename, short_desc, long_desc, date):
    """Copy a file to my PhD logbook and add entry in logbook."""
    logger.debug(f'''Initial variables:
    - filename: {filename},
    - short_desc: {short_desc},
    - long_desc: {long_desc},
    - date: {date}''')

    dest = LOGBOOK / 'images' / f'{date}-{short_desc}{Path(filename).suffix}'
    logger.debug(f'dest exists? {dest.exists()}')

    if not dest.exists() or click.confirm('Overwrite existing file?'):
        copy(str(filename), str(dest))
        _add2logbook(date, dest, long_desc)
