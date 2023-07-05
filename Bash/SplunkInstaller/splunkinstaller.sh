#!/bin/bash
# Script to install Splunk on CentOS/RHEL distributions
# Written by Nick Lindstrom
# May 2023

# LogFile=/var/log/splunk # Log file location

SplunkInstaller=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo permissions."
    exit 1
else

# Function to install the RPM for version CentOS 7
   InstallFunction () {
    echo "Installing Splunk for CentOS"
    # Create splunk user and group
    useradd -m splunk
    groupadd splunk
    # Create and splunk directory to environment
    export SPLUNK_HOME=/opt/splunkforwarder
    mkdir $SPLUNK_HOME
    # Copy over the rpm package from the installer folder
    cp $SplunkInstaller/RPM/*.rpm $SPLUNK_HOME
    # Install splunk
    rpm -i $SPLUNK_HOME/*.rpm &
    process_id=$!
    wait $process_id
    # Change owner of Splunk directory
    chown -R splunkLsplunk $SPLUNK_HOME
    # Start program and set configuration
    $SPLUNK_HOME/bin/splunk start --accept-license --no-prompt
    sudo $SPLUNK_HOME/bin/splunk set deploy-poll domain:portnumber

    echo "Install is completed"
   }

   InstallFunction
fi
