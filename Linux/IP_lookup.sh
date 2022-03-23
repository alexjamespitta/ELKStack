#!/bin/bash

IP_address="104.223.95.86"

curl -s http://ipinfo.io/$IP_address | grep "country" | awk '{print $2}'

