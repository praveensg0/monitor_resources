#!/usr/bin/perl

use strict;
use warnings;

sub monitor_resources {
    while (1) {
        # Collect system resource data
        my $cpu_percent = `top -bn1 | grep "Cpu(s)" | sed "s/.*, *\\([0-9.]*\\)%* id.*/\\1/" | awk '{print 100 - \$1}'`;
        my $mem_percent = `free | awk '/Mem/{print \$3/\$2 * 100}'`;
        my $disk_percent = `df / | awk 'NR==2 {print \$5}'`;
        my $net_sent = `cat /proc/net/dev | awk 'NR==3 {print \$10}'`;
        my $net_recv = `cat /proc/net/dev | awk 'NR==3 {print \$2}'`;

        # Display real-time feedback
        print "CPU Usage: $cpu_percent%";
        print "Memory Usage: $mem_percent%";
        print "Disk Usage: $disk_percent";
        print "Network Sent: $net_sent bytes\n";
        print "Network Received: $net_recv bytes";

        # Sleep for 10 seconds
        sleep(10);
        # Clear the terminal for better display
        system("clear");
    }
}

# Call the monitor_resources function
monitor_resources();
