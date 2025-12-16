Week 3: Application Selection for Performance Testing

3.1 Application Selection Matrix

Application	Workload Type	Purpose	Justification

| Application | Workload Type | Purpose | Justification |
|-------------|--------------|---------|---------------|
| **Stress-ng** | CPU-intensive | Generates various types of system load for stress testing | Industry-standard tool for CPU stress testing; allows controlled simulation of compute-heavy workloads; supports multiple CPU stress methods (matrix, cpu, etc.) |
| **Memtester** | RAM-intensive | Tests memory subsystems for errors under load | Specialized tool for memory stress testing; provides detailed error reporting; simulates memory-intensive applications like in-memory databases |
| **fio (Flexible I/O Tester)** | I/O-intensive | Measures and tests disk I/O performance | Standard tool for storage benchmarking; supports various I/O patterns (random/sequential read/write); simulates database and file server workloads |
| **iperf3** | Network-intensive | Network performance measurement tool | Industry standard for network throughput testing; measures TCP/UDP bandwidth; simulates network-heavy applications like media streaming |
| **nginx** | Server Application | High-performance web server/proxy | Real-world server application; measures service response times; simulates production web server workload with configurable load |

# 3.2 Installation Documentation

SSH-Based Installation Commands

```bash

 Connect to server via SSH (from workstation)
ssh asus123@192.168.56.103
```

# Update package list and upgrade existing packages
```bash
sudo apt update && sudo apt upgrade -y
```

# Install CPU stress testing tool
```bash
sudo apt install stress-ng -y
```
# Install memory testing tool
```bash
sudo apt install memtester -y
```

# Install I/O benchmarking tool
```bash
sudo apt install fio -y
```

# Install network performance tool
```bash
sudo apt install iperf3 -y
```

# Install web server
```bash
sudo apt install nginx -y
```

# Install additional monitoring tools
```bash
sudo apt install sysstat htop iftop -y
```

# Install Apache Benchmark for web server testing
```bash
sudo apt install apache2-utils -y
```
Verification Commands:

```bash
# Verify installations
stress-ng --version
memtester --version
fio --version
iperf3 --version
nginx -v
3.3 Expected Resource Profiles
CPU-intensive (stress-ng)
CPU Usage: 100% across specified cores
```
Memory Usage: 50-100MB (depending on test configuration)


Disk I/O: Minimal (unless disk I/O stress tests are included)

Network: Minimal

Expected System Load: 5.0+ (depending on core count)

Duration: Configurable (default 5-10 minutes per test)

RAM-intensive (memtester)
CPU Usage: 10-30% (for memory operations)

Memory Usage: 80-95% of allocated memory

Disk I/O: Minimal (swap usage if memory exhausted)

Network: None

Expected Memory Pressure: High (potentially triggering OOM killer if oversubscribed)

Duration: Varies by memory size (1GB takes ~2-3 minutes)

I/O-intensive (fio)
CPU Usage: 20-40% (for I/O scheduling)

Memory Usage: 50-200MB (for buffers)

Disk I/O: 100% of disk capability (reads/writes)

Network: None

Expected Disk Throughput: 50-200MB/s (SSD) or 20-80MB/s (HDD)

IOPS: 1000-8000 (SSD) or 50-150 (HDD)

Network-intensive (iperf3)
CPU Usage: 30-70% (for packet processing)

Memory Usage: 50-150MB (for buffer management)

Disk I/O: Minimal

Network: 100-1000Mbps (depending on network interface)

Expected Throughput: 900+Mbps (gigabit), 90+Mbps (100Mbps)

Latency: 0.1-10ms (depending on network quality)

Server Application (nginx)
CPU Usage: 5-40% (depending on request load)

Memory Usage: 20-100MB (base, more with caching)

Disk I/O: Moderate (log files, static content serving)

Network: Variable (depending on client connections)

Concurrent Connections: 100-1000+ (depending on configuration)

Response Time: <100ms for static content

3.4 Monitoring Strategy
Measurement Approach for Each Application
1. CPU-intensive (stress-ng) Monitoring
```bash
# Real-time monitoring during stress test
top -b -n 60 -d 1 > cpu_stress_monitor.log
```
# CPU-specific metrics
```bash
mpstat -P ALL 1 60 > cpu_breakdown.log
```
# System load tracking
```bash
uptime | tee -a system_load.log
```

# Per-process CPU usage
```bash
pidstat 1 60 -u -p $(pgrep stress-ng) > stress_process.log
```
Metrics Collected:

Overall CPU utilization percentage

Per-core CPU usage breakdown

System load averages (1, 5, 15 minutes)

Context switches per second

Process-specific CPU time

2. RAM-intensive (memtester) Monitoring
```bash
# Memory usage tracking
free -m -s 1 -c 60 > memory_usage.log
```
# Swap activity monitoring
```bash
vmstat 1 60 > vm_stats.log
```

# Detailed memory statistics
```bash
cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable|Swap" > memory_details.log
```
# Process memory tracking
```bash
ps aux --sort=-%mem | head -10 > top_memory_processes.log
```
Metrics Collected:

Total, used, free, available memory

Swap usage and swap activity

Memory pressure indicators

OOM killer activity (if triggered)

Cache and buffer utilization

3. I/O-intensive (fio) Monitoring
```bash
# Disk I/O monitoring
iostat -x 1 60 > disk_io.log
```
# Disk-specific statistics
```bash
iotop -b -n 60 -d 1 > io_processes.log
```
# File system usage
```bash
df -h > disk_usage.log
```
# I/O wait statistics
```bash
vmstat 1 60 | awk '{print $16}' > io_wait.log
```
Metrics Collected:

Read/write throughput (MB/s)

IOPS (Input/Output Operations Per Second)

I/O wait percentage

Disk utilization percentage

Average request size and queue length

4. Network-intensive (iperf3) Monitoring
bash
# Network interface statistics
ifstat -t 1 60 > network_traffic.log

# Detailed interface monitoring
sar -n DEV 1 60 > network_stats.log

# Connection tracking
ss -s > connection_summary.log

# Bandwidth monitoring
nload -u M -t 1000 enp0s8 > realtime_bandwidth.log
Metrics Collected:

Network throughput (Mbps)

Packet count (tx/rx)

Error/drop rates

Connection count and states

Latency measurements

5. Server Application (nginx) Monitoring
bash
# Web server access logs
tail -f /var/log/nginx/access.log > web_access.log &

# Server status monitoring
curl http://localhost/nginx_status > nginx_status.log

# Response time measurement
ab -n 1000 -c 100 http://localhost/ > apache_benchmark.log


# Process monitoring
ps aux | grep nginx > nginx_processes.log
Metrics Collected:

Request rate (requests/second)

Response times (min, max, average)

Concurrent connections

HTTP status code distribution

Server resource usage during load

# 3.5 Automated Monitoring Script Framework
```bash
!/bin/bash
monitor-app.sh - Automated monitoring wrapper
Usage: ./monitor-app.sh <application> <duration_seconds>

APP=$1
DURATION=$2
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOGDIR="/home/asus123/performance_logs"

mkdir -p $LOGDIR

case $APP in


"stress-ng")
    # Start monitoring in background
    mpstat -P ALL 1 $DURATION > "$LOGDIR/cpu_$TIMESTAMP.log" &
    # Run application
    stress-ng --cpu 4 --timeout "$DURATION"
    ;;
"memtester")
    free -m -s 1 -c "$DURATION" > "$LOGDIR/mem_$TIMESTAMP.log" &
    memtester 512M $((DURATION/60))
    ;;
# ... additional application cases
```

esac  
3.6 Testing Schedule  
Test Scenario	Application	Duration	Monitoring Tools	Expected Output  
Baseline	All	5 min	sysstat, vmstat	System idle performance  
CPU Stress	stress-ng	10 min	mpstat, top	CPU utilization graphs  
Memory Test	memtester	5 min	free, vmstat	Memory bandwidth & latency  
Disk I/O	fio	15 min	iostat, iotop	Throughput & IOPS charts  
Network	iperf3	10 min	ifstat, nload	Bandwidth & latency data  
Web Server	nginx + ab	10 min	nginx logs, ab	Request/response metrics  

# 3.7 Data Collection Plan
Storage Strategy:
```bash
# Directory structure for performance data
/home/asus123/performance_data/
├── cpu_tests/
├── memory_tests/
├── disk_tests/
├── network_tests/
└── server_tests/
```
Data Retention:
Raw logs: 7 days

Processed metrics: 30 days

Summary reports: Permanent

Analysis Tools:
gnuplot for graph generation

Python pandas for data analysis

Excel/Google Sheets for final reporting

Manual review for anomaly detection
