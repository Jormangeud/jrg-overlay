#!/usr/bin/env python3

import os
import sys

with open(sys.argv[1]) as file:
    for line in file:
        tags = line.strip().split('\t')
        package = tags[0].split('/')
        conf = tags[1].split('.')[0]
        confdir = f"package.env/{conf}/{package[0]}"
        os.makedirs(confdir, exist_ok=True)
        with open(f"{confdir}/{package[1]}", "w+") as savefile:
            savefile.write(line)
