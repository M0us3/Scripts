# Written by Nick Lindstrom
# Date 1-July-2022
# Version 0.5

# Requirements to run script, Python with installed modules Paramiko, SCP, and Getpass

# Purpose of this script is to automate copying folders and files
# This script will use SCP to copy folders and files from the host to a remote host
# Paramiko is used to establish SSH connection and send commands to remote host
# Getpass is used to hide credentials that is entered


# Import modules and classes
import os
from paramiko import SSHClient, AutoAddPolicy
from scp import SCPClient
import getpass

# Credentials for remote host connection
print("Enter credentials that are used on the remote host")
hostname = input("Hostname: ")
username = input("Username: ")
password = getpass("Password: ")

# Connect to host with ssh
print("Connecting to " &hostname)
client = SSHClient()
client.set_missing_host_key_policy(AutoAddPolicy())
client.load_system_host_keys()
client.connect(hostname, username=username, password=password)

# Verify folders are correct

# Copy files to remote host
print("Enter the local folder path and destination path that you want to copy")

local_folder = input("Local path: ")

remote_folder = input("Remote folder path: ")

scp = SCPClient(ssh.get_transport())
scp.put(local_folder, recursive=True, remote_path=remote_folder)

scp.close()

# Verify folders exist, if remote folder does not exist ask if user want to create the folder


# Run commands on remote host


# Disconnectnect
