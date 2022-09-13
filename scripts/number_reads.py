#!/usr/bin/env python3

import subprocess
import sys

command = ' '.join(["seqtk comp", sys.argv[1], "| awk '{t += $2} END {print t}'"])
subprocess_out = subprocess.run(command, capture_output=True, shell=True)
genome_size = int(subprocess_out.stdout.decode("utf-8").rstrip('\n').split('\n')[0])
print(genome_size)
n_reads = genome_size * 50 / 600
print(int(round(n_reads, 0)))
