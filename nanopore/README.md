# Viralrecon Nanopore workflow in Common Workflow Language

```
$ git clone https://github.com/inutano/viralrecon-cwl
$ cd viralrecon-cwl/nanopore
$ ./setup.sh
$ cd test
$ cwltool --debug --cachedir ./cache/ ../workflow/viralrecon.nanopore.cwl test.job.yml
```
