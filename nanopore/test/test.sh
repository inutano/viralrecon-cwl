#!/bin/sh
cwltool \
  --debug \
  --cachedir ./cache/ \
  ../workflow/viralrecon.nanopore.cwl \
  test.job.yml
