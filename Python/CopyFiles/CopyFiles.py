# Written by Nick Lindstrom
# Date November-2022
# Version 1

# Requirements to run script, Python with installed modules Paramiko, SCP, and Getpass

# Purpose of this script is to automate copying folders and files
# This script will use SCP to copy folders and files from the host to a remote host
# Paramiko is used to establish SSH connection and send commands to remote host
# Getpass is used to hide credentials that is entered


# Import modules and classes
import os
from paramiko import SSHClient, AutoAddPolicy
from scp import SCPClient
import getpass, sys

# Credentials for remote host connection
print("Enter credentials for the remote host")
hostname = input("Hostname or IP: ")
username = input("Username: ")
password = getpass.getpass("Password: ")

# Connect to host with ssh
print("Connecting to " + hostname)
client = SSHClient()
client.set_missing_host_key_policy(AutoAddPolicy())
client.load_system_host_keys()
client.connect(hostname, username=username, password=password)

# Local and remote path
print("Enter the folder paths.")

local_folder = input("Source: ")

remote_folder = input("Destination: ")

# Copy files to remote host
print("Copying files")
# Provide copy progress
def progress(filename, size, sent):
    sys.stdout.write("%s's progress: %.2f%%   \r" % (filename, float(sent)/float(size)*100) )
scp = SCPClient(client.get_transport(), progress=progress)
scp.put(local_folder, recursive=True, remote_path=remote_folder)
print("Copy completed: ")

# Disconnect session
scp.close()
