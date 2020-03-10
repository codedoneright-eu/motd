#!/bin/bash

# Set colours
CNC='\e[0m' # No color
C0='\033[1;37m' # White
C1='\033[0;35m' # Purple
C2='\033[0;37m' # Light Gray
C3='\033[1;32m' # Light Green
C4='\033[0;31m' # Red
C5='\033[1;33m' # Yellow
C6='\033[0;34m' # Blue

# Check current user
USER=$(whoami)

# Check current user's groups
GROUPZ=$(groups)

# Check and format the open ports on the machine
OPEN_PORTS_IPV4=$(netstat -lnt | awk 'NR>2{print $4}' | grep -E '0.0.0.0:' | sed 's/.*://' | sort -n | uniq | awk -vORS=, '{print $1}' | sed 's/,$/\n/')
OPEN_PORTS_IPV6=$(netstat -lnt | awk 'NR>2{print $4}' | grep -E ':::' | sed 's/.*://' | sort -n | uniq | awk -vORS=, '{print $1}' | sed 's/,$/\n/')


# The following checks the status of various services, if you are not running a 
# particular service comment the corresponding line, and comment the corresponding line
# from the output at the bottom
apache_STATUS=$(systemctl status apache2 | grep "Active: " | awk '{print $2}')
samba_STATUS=$(systemctl status smbd | grep "Active: " | awk '{print $2}')
sshguard_STATUS=$(systemctl status sshguard | grep "Active: " | awk '{print $2}')
clamav_STATUS=$(systemctl status clamav-freshclam | grep "Active: " | awk '{print $2}')
postfix_STATUS=$(systemctl status postfix | grep "Active: " | awk '{print $2}')
dovecot_STATUS=$(systemctl status dovecot | grep "Active: " | awk '{print $2}')
ufw_STATUS=$(systemctl status ufw | grep "Active: " | awk '{print $2}')
vsftpd_STATUS=$(systemctl status vsftpd | grep "Active: " | awk '{print $2}')
mysql_STATUS=$(systemctl status mysql | grep "Active: " | awk '{print $2}')


# Modify this line by removing + signs so it closes nicely. Currently is assumes
# that the username has 2 chars. If your user has 5 chars remove 3 more + signs
echo "${C1}+++++++++++++++++++++: Welcome $USER :+++++++++++++++++++++++++++++++
"

echo "${C1}++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
${C1}+   ${C3}Service ufw			${C1}+   ${C4}$ufw_STATUS
${C1}+   ${C3}Service sshguard	${C1}+   ${C4}$apache_STATUS
${C1}+   ${C3}Service ClamAV		${C1}+   ${C4}$clamav_STATUS
${C1}+   ${C3}Service vsftpd		${C1}+   ${C4}$vsftpd_STATUS
${C1}+   ${C3}Service MySQL		${C1}+   ${C4}$mysql_STATUS
${C1}+   ${C3}Service Apache		${C1}+   ${C4}$apache_STATUS
${C1}+   ${C3}Service Samba		${C1}+   ${C4}$samba_STATUS
${C1}+   ${C3}Service Postfix		${C1}+   ${C4}$postfix_STATUS
${C1}+   ${C3}Service Dovecot		${C1}+   ${C4}$dovecot_STATUS
${C1}++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
