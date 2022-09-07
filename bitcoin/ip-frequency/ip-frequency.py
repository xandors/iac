#!/usr/bin/env python3

import itertools
import operator
import argparse
from collections import Counter
from pprint import pprint as pp

file_name = "ips.txt"

parser = argparse.ArgumentParser("ip-frequency")
parser.add_argument("filepath", help="path to the access log file", type=argparse.FileType('r'))
parser.add_argument("head", help="Amount of lines to show.", type=int)
args = parser.parse_args()

log_lines = args.filepath.readlines()
head_count = len(log_lines) if args.head == 0 else args.head

ips = []

for line in log_lines:
    ips.append(line.split(" ")[1])

ips_counter = Counter(ips)
ordered_ips = dict(sorted(sorted(ips_counter.items()),
                   key=operator.itemgetter(1),
                   reverse=True))

for key, value in itertools.islice(ordered_ips.items(), 0, head_count):
    print(f"{value} {key}")
