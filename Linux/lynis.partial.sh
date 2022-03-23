#!/bin/bash

sudo lynis audit --cronjob --tests-from-group malware,authentication,networking,storage,filesystems > /tmp/lynis.partial_scan.log
