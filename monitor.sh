#!/bin/bash

monitor_resources() {
    while true; do
        # Collect system resource data
        cpu_percent=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
        mem_percent=$(free | awk '/Mem/{print $3/$2 * 100}')
        disk_percent=$(df / | awk 'NR==2 {print $5}')
        net_sent=$(cat /proc/net/dev | awk 'NR==3 {print $10}')
        net_recv=$(cat /proc/net/dev | awk 'NR==3 {print $2}')

        # Display real-time feedback
        echo "CPU Usage: $cpu_percent%"
        echo "Memory Usage: $mem_percent%"
        echo "Disk Usage: $disk_percent%"
        echo "Network Sent: $net_sent bytes"
        echo "Network Received: $net_recv bytes"

        # Sleep for 1 second
        sleep 10
        # Clear the terminal for better display
        clear
    done
}

# Call the monitor_resources function
monitor_resources