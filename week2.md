Week 2: Security Planning and Testing Methodology

1. Performance Testing Plan
   Remote Monitoring Methodology
To evaluate system performance under different workloads, I will implement a remote monitoring approach using SSH-based data collection. The methodology will involve:

Baseline Measurement: Recording system metrics (CPU, RAM, disk I/O, network) under idle conditions

Application Testing: Running selected applications while collecting performance data
Comparative Analysis: Comparing performance across different workload types

Testing Approach
Tool Selection: Using sysstat package (specifically sar, iostat, mpstat) for comprehensive system monitoring

Data Collection: Running monitoring scripts via SSH from the workstation to the server

Metrics Tracked:

CPU utilization (user, system, idle percentages)

Memory usage (used, free, cached, swap)

Disk I/O (read/write operations, throughput)

Network (latency, bandwidth, packet loss)

Testing Duration: Each test will run for 5 minutes with metrics collected at 10-second intervals

Remote Execution Strategy
All performance tests will be executed via SSH using pre-configured scripts. This ensures consistency and eliminates direct server access bias.

2. Security Configuration Checklist
SSH Hardening
Disable root SSH login

Use key-based authentication only

Change default SSH port (optional, for additional security)

Configure SSH timeout and max authentication attempts

Disable empty passwords

Use strong ciphers and MAC algorithms

Firewall Configuration
Configure UFW (Uncomplicated Firewall) to allow only necessary ports

Restrict SSH access to workstation IP only

Deny all incoming connections by default

Log dropped packets for monitoring

Mandatory Access Control
Install and configure AppArmor (chosen over SELinux for Ubuntu compatibility)

Set profiles for key applications

Configure audit logging for access violations

Automatic Updates
Configure unattended-upgrades for security patches

Set update schedule (daily security updates)

Configure automatic reboot if required by kernel updates

Verify update logs regularly

User Privilege Management
Create non-root administrative user with sudo privileges

Implement principle of least privilege

Set password policies (complexity, expiration)

Configure sudo timeout

Network Security
Disable unnecessary network services

Configure TCP wrappers where applicable

Set up basic intrusion detection with fail2ban

Implement port knocking for additional SSH security (optional)

3. Threat Model
Threat 1: Unauthorized SSH Access
Description: Attackers attempting brute-force attacks on SSH service

Attack Vector: Internet-facing SSH port with weak authentication

Impact: Complete system compromise

Mitigation Strategies:

Implement key-based authentication only

Configure fail2ban to block repeated failed attempts

Restrict SSH access to specific IP addresses

Use non-standard SSH port

Threat 2: Denial of Service (DoS)
Description: Resource exhaustion attacks targeting server availability

Attack Vector: Network floods or process exhaustion

Impact: Service disruption, performance degradation

Mitigation Strategies:

Configure firewall rate limiting

Implement system resource limits via ulimit

Use kernel parameters to resist SYN floods

Monitor for abnormal resource usage patterns

Threat 3: Privilege Escalation
Description: Attackers gaining unauthorized elevated privileges

Attack Vector: Exploiting vulnerabilities in services or misconfigurations

Impact: Complete system control, data compromise

Mitigation Strategies:

Regular security updates

AppArmor mandatory access control

Principle of least privilege for all services

Regular vulnerability scanning with Lynis

Technical Implementation Evidence
System Information Collection
bash
# Gather baseline system information
uname -a
free -h
df -h
ip addr show
lsb_release -a
Security Tools Installation
bash
# Install security and monitoring tools
sudo apt update
sudo apt install -y ufw fail2ban unattended-upgrades apparmor apparmor-utils sysstat
Initial Security Configuration
bash
# Check AppArmor status
sudo apparmor_status

# Enable automatic security updates
sudo dpkg-reconfigure --priority=low unattended-upgrades
