#!/bin/bash

sudo lynis audit system --cronjob > /tmp/lynis.system_scan.log
