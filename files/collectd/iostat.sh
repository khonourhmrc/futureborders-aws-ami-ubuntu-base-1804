#!/usr/bin/env bash

HOSTNAME="${COLLECTD_HOSTNAME:-localhost}"
INTERVAL="${COLLECTD_INTERVAL:-60}"

IOSTAT_CMD="iostat -Nxk 1 1"

while sleep "$INTERVAL"; do

   ${IOSTAT_CMD}|awk -vS1="${HOSTNAME}" 'BEGIN { in_devices = 0 }
      /^Device:/ { in_devices = 1; next }
      !/^$/ && NF == 14 { if(in_devices == 1){ 
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/avgqusz N:" $9
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/avgrqsz N:" $8
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/await N:" $10
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/rawait N:" $11
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/rkbsec N:" $6
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/rrqm N:" $2
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/rs N:" $4
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/svctm N:" $13
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/util N:" $14
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/wawait N:" $12
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/wkbsec N:" $7
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/wrqm N:" $3
         print "PUTVAL " S1 "/iostat/gauge-" $1 "/ws N:" $5
      } }'

done

