#!/bin/sh
mkdir -p ./output
cwltool \
  --debug \
  --outdir ./output \
  --cachedir ./cache/ \
  ../workflow/viralrecon.nanopore.cwl \
  test.job.yml
