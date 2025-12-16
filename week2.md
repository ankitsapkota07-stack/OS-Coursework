Week 2: Security Planning and Testing Methodology

2.1 Performance Testing Plan

Remote Monitoring Methodology

My performance testing will use a dual-system approach where the workstation (boxuser@ubuntu) remotely monitors the server (asus123@asus). The methodology includes:

Monitoring Tools Selection:

top/htop: Real-time CPU and memory monitoring

vmstat: System performance statistics

iostat: Disk I/O performance tracking

nload/iftop: Network bandwidth monitoring

sysstat package: Historical performance data collection

Custom scripts: For automated metric collection via SSH

  Testing Approach:

Baseline Measurement: Capture system performance under idle conditions

Application Load Testing: Monitor resource usage during application execution

Stress Testing: Push system to limits using stress-ng tool

Comparative Analysis: Compare performance across different workload types

Continuous Monitoring: Scheduled data collection every 5 minutes during testing phases

Data Collection Strategy:

Performance metrics will be collected via SSH from workstation to server

Data will be logged to CSV files for analysis

Visualization using gnuplot or Python matplotlib

Results will include quantitative metrics with timestamps

2.2 Security Configuration Checklist
1. SSH Hardening
Disable root SSH login

Change default SSH port from 22 (Optional - for assessment)

Implement key-based authentication

Disable password authentication

Configure SSH session timeout

Limit SSH access to specific IP (workstation: 192.168.56.1)

Use strong encryption algorithms only

2. Firewall Configuration
Configure ufw (Uncomplicated Firewall)

Allow SSH only from workstation IP

Deny all other incoming connections

Enable logging for firewall events

Set default policies: deny incoming, allow outgoing

3. Mandatory Access Control
Install and configure AppArmor (Ubuntu default)

Set profiles for critical applications

Enable enforcement mode

Regular audit of access control violations

4. Automatic Updates
Configure automatic security updates

Schedule regular system updates

Enable email notifications for updates

Create update rollback plan

5. User Privilege Management
Create non-root administrative user

Implement sudo privileges with restrictions

Regular audit of user accounts

Password policy enforcement

Remove unnecessary default accounts

6. Network Security
Disable unnecessary network services

Configure IPTables for additional filtering

Implement fail2ban for intrusion prevention

Regular port scanning audits

Network segmentation verification

2.3 Threat Model
Threat 1: Unauthorized SSH Access
Description: Attackers attempting brute-force attacks on SSH service running on port 22.

Attack Vectors:

Password spraying attacks

SSH vulnerability exploits (CVE-2024-6387)

Credential stuffing using common passwords

Impact:

Unauthorized system access

Data exfiltration

System compromise and backdoor installation

Mitigation Strategies:

Implement key-based authentication

Configure fail2ban to block repeated login attempts

Change default SSH port (optional)

Use firewall to restrict SSH to workstation IP only

Regular SSH key rotation

Threat 2: Denial of Service (DoS) Attacks
Description: Resource exhaustion attacks targeting server availability.

Attack Vectors:

SYN flood attacks

Application-layer attacks

Resource exhaustion through malicious processes

Impact:

Service unavailability

Performance degradation

System instability

Mitigation Strategies:

Configure kernel parameters for DoS protection

Implement rate limiting using iptables

Monitor system resources with alerts

Use ulimit to restrict process resources

Regular backup of critical configurations

Threat 3: Privilege Escalation
Description: Unauthorized elevation of user privileges to gain root access.

Attack Vectors:

Exploitation of sudo vulnerabilities

Kernel exploits targeting CVE-2024-1086

Misconfigured file permissions

Impact:

Complete system compromise

Bypass of all security controls

Installation of persistent malware

Mitigation Strategies:

Regular sudo configuration audits

Kernel updates and patch management

Principle of least privilege for all users

SELinux/AppArmor enforcement

Regular security scanning with Lynis

2.4 Implementation Roadmap
Week 2 Completion Status:
Performance testing methodology defined

Security checklist created

Threat model documented with 3 threats

Begin initial security implementations (Week 4)

Tools Identified for Implementation:
SSH Hardening: ssh-keygen, ssh-copy-id, /etc/ssh/sshd_config

Firewall: ufw, iptables-persistent

Access Control: apparmor, aa-status

Monitoring: sysstat, sar, custom Bash scripts

Security Scanning: lynis, nmap, chkrootkit

2.5 Risk Assessment Matrix
Threat	Likelihood	Impact	Risk Level	Mitigation Priority
SSH Brute Force	High	High	Critical	1
DoS Attacks	Medium	High	High	2
Privilege Escalation	Low	Critical	High	3
