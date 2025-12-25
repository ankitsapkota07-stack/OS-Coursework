# Week 7: Security Audit and System Evaluation
# Overview
This week focused on conducting a comprehensive security audit of the Linux server to evaluate the effectiveness of security controls implemented throughout the coursework. The audit included vulnerability scanning, network security assessment, access control verification, and service analysis.
# 1. Lynis Security Scanning
# Initial Security Assessment
I began by running Lynis, a security auditing tool, to identify potential vulnerabilities and security misconfigurations:
https://images/week-7-lynis-command-execution.png
# Hardening Index Results
The Lynis scan revealed a hardening index of 65/100, indicating moderate security posture with room for improvement:
https://images/week-7-lynis-hardening-index.png
# Key Findings and Recommendations
The scan identified several areas for improvement:
•	LYNIS-0000: Lynis version is more than 4 months old (update recommended)
•	BOOT-5122: No password set on GRUB boot loader
•	DEB-0280: Missing libpam-tmpdir for secure PAM sessions
•	DEB-0810: Missing apt-listbugs for critical bug notifications
https://images/week-7-lynis-showing-vulnerabilities.png
# 2. Network Security Assessment
Nmap Port Scanning
Conducted network security assessment using Nmap to identify open ports and services:
bash
sudo nmap -sS 192.168.56.103
https://images/week-7-nmap-scan-results.png
Port Analysis Results
•	Port 80/tcp (HTTP): Open - Running nginx web server
•	Port 2222/tcp: Open - Custom SSH port for secure access
•	998 closed ports: No unnecessary services exposed
•	No unexpected open ports: Good security practice
# 3. Access Control Verification
SSH Key-Based Authentication
Verified that SSH key-based authentication is properly configured and functional:
https://images/week-7-authorized-keys-on-server.png
# SSH Security Configuration
Confirmed SSH security hardening measures:
https://images/week-7-ssh-verification.png
Key SSH configurations verified:
•	Port 2222: Non-standard SSH port
•	PermitRootLogin no: Root login disabled
•	PasswordAuthentication no: Password authentication disabled
•	Protocol 2: Only SSH protocol 2 allowed
# User Access Controls
Checked sudo privileges and SSH access controls:
https://images/week-7-access-control-verification.png
•	sudo group includes: asus123, sysadmin
•	SSH AllowUsers: asus123, sysadmin
•	Proper privilege separation implemented
# 4. Service Audit and Justification
Running Services Analysis
Conducted a comprehensive audit of all running services:
https://images/week-7-list-0f-running-services.png
Service Justification
Service	Justification	Security Assessment
cron	Essential for scheduled tasks	Required, properly secured
dbus	System message bus	Required for system communication
fail2ban	Intrusion prevention	Security enhancement - required
nginx	Web server	Required for web services
polkit	Authorization management	Required for privilege management
rsyslog	System logging	Required for audit trails
ssh	Remote administration	Required, properly hardened
systemd- services*	Core system services	Required for system operation
udisks2	Disk management	Required for storage management
SSH Service Status
Verified SSH service is running properly with appropriate resource usage:
https://images/week-7-ssh-service-status.png
# 5. Firewall Configuration Review
UFW Status and Rules
Reviewed firewall configuration and rules:
https://images/week-7-firewall-status.png
Firewall Rules Analysis
•	Status: Active
•	Default policy: Deny incoming, allow outgoing
•	Custom rules:
o	Allow SSH (port 2222) from 192.168.56.0/24
o	Allow SSH (port 2222) from 192.168.56.104
•	No unnecessary ports open: Good practice
# 6. Security Audit Report
Comprehensive Security Summary
Generated a final security audit report:
https://images/week-7-security-audit-report.png
Audit Results Summary
text
=== WEEK 7 SECURITY AUDIT SUMMARY ===
Thu Dec 25 01:15:59 AM UTC 2025
Hostname: asus

1. Lynis Score: 65/100
2. Open Ports: 2222 (SSH)
3. Running Services: 22 services
4. SSH Security: Key-based auth, no password
5. Firewall: Active, only SSH allowed
6. Updates: Automatic security updates enabled
7. Intrusion Detection: fail2ban active
8. Access Control: AppArmor configured

=== AUDIT COMPLETE ===
# 7. Remediation Actions Implemented
Critical Security Improvements
Based on Lynis recommendations, implemented:
1.	Updated Lynis to latest version
2.	Installed missing security packages:
```
bash
sudo apt install libpam-tmpdir apt-listbugs apt-listchanges
```
3.	Enhanced GRUB security (pending BIOS/UEFI considerations)
4.	Reviewed and documented all SUID/SGID binaries
SSH Key Authentication Verification
Tested key-based authentication to ensure proper functionality:
https://images/week-7-sucessful-key-based-authentication.png
# 8. Risk Assessment and Remaining Vulnerabilities
Residual Risk Analysis
Risk Level	Vulnerability	Mitigation Status
Low	Outdated Lynis version	Updated post-audit
Medium	No GRUB password	Requires physical access mitigation
Low	Missing optional packages	Installed during remediation
None	Unnecessary open ports	All non-essential ports closed
Security Strengths
1.	Strong SSH hardening (non-standard port, key-based auth only)
2.	Minimal service footprint (only required services running)
3.	Proper firewall configuration (default deny, specific allow rules)
4.	Regular automatic updates enabled
5.	Intrusion detection with fail2ban
# 9. Reflection and Learning Outcomes
Technical Skills Developed
•	Security auditing with Lynis and Nmap
•	Service analysis and justification methodology
•	Risk assessment and prioritization techniques
•	Remediation implementation based on audit findings
Security vs Performance Trade-offs
The security audit revealed several important trade-offs:
1.	Service reduction vs functionality: Disabling unnecessary services improves security but may limit functionality
2.	Access control vs convenience: Strict SSH controls enhance security but require key management
3.	Firewall strictness vs accessibility: Default deny policies are secure but require explicit allow rules
Quantitative Security Metrics
•	Initial Lynis score: 65/100
•	Open ports reduction: From default to 2 essential ports
•	Running services: 22 (all justified and required)
•	Security controls implemented: 8 major security mechanisms
# 10. Conclusion
The Week 7 security audit demonstrated that the Linux server has been effectively secured through systematic hardening. The Lynis score of 65/100, while indicating room for improvement, reflects a solid security foundation with all critical controls implemented.
Key achievements include:
•	✅ SSH properly hardened with key-based authentication only
•	✅ Firewall correctly configured with minimal attack surface
•	✅ Essential services only running with documented justifications
•	✅ Automatic security updates enabled
•	✅ Intrusion detection active with fail2ban
The audit process highlighted the importance of continuous security monitoring and the need for regular vulnerability assessments. The implemented security controls provide a robust defense against common threats while maintaining necessary system functionality for the server's intended purpose.

