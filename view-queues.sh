#!/bin/bash
dir="$(dirname "$0")"
source "$dir/util/print-table.sh"

declare -A queues

echo "Queue,MessageCount" > /tmp/temp_result
for queue in $(cat $dir/configs/queues.config)
do
    queueName=$(echo $queue | awk -F '/' '{ print $5 }')
    result=$( \
                aws sqs get-queue-attributes --queue-url $queue \
                --attribute-names ApproximateNumberOfMessages 2>/dev/null \
                | grep ApproximateNumberOfMessages \
                | awk -F ": " '{ print $2 }' \
                | sed s/\"//g \
            )
    
    echo "$queueName,$result" >> /tmp/temp_result
done

printTable "," "$(cat /tmp/temp_result)"

rm /tmp/temp_result