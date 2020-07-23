#!/bin/sh

echo "Starting startup.sh.."
echo "*     *     *     *     *     run-parts /etc/periodic/1min" >> /etc/crontabs/root
echo

echo "Listing crons (crontab -l)"
echo "---"
crontab -l
echo

echo "Starting (crond -l 2 -f)"
crond -l 2 -f
echo
