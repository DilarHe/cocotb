#!/bin/bash
make patch_merge_rtl
make -j$(nproc) sim | tee sim.log