#!/bin/bash
# Copyright lowRISC contributors.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

# Builds all of the register svgs from their json description.  Uses wavedrom
# bitfield see https://github.com/wavedrom/bitfield for more information.

for f in *.json
do
  echo "Building $f..."
  npx bit-field --fontsize 12 --lanes 1 -i $f > ${f%.*}.svg
done

