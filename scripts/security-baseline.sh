#!/bin/bash
# security-baseline.sh
# This script verifies security configurations for CMPN202 coursework

echo "=== Security Baseline Check ==="
echo "Running checks for SSH, firewall, and system security..."

# Add your security checks here
# Example: Check if SSH is running
systemctl status ssh --no-pager

echo "Security baseline check complete."
