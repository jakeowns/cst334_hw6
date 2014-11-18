#!/bin/bash

jobsLocation=/home/cst334/HW6/Job[0-9]*

declare -a jobs

for i in $jobsLocation
do
  jobs+=(`/usr/bin/time -f "%e" $i | grep -v "Running"`)
done

count=1
for i in ${jobs[@]}
do
  if [ $count -eq 1 ]; then
    echo "Job$count burst-time: $i wait-time: 0"
  else
    echo "Job$count burst-time: $i wait-time: $jobs[$count]"
  fi
  (($count++))
done

