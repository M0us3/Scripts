# Import modules and classes
from paramiko import SSHClient, AutoAddPolicy
from scp import SCPClient
import getpass

# hostname, credentials, and local folder
files = ("folder location")
hostname = input("Hostname: ")
username = input("Username: ")
password = input("Password: ")


# Connect to host
client = SSHClient()
client.load_host_keys('C:/users/nlindstrom/.ssh')
client.set_missing_host_key_policy(AutoAddPolicy())
client.load_system_host_keys()
client.connect(hostname, username=username, password=password)

# Copy files to remote host


# Run commands on remote host


# Disconnect
