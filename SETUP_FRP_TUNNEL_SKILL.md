# Global Skill: FRP Tunnel Setup

## Overview
This skill helps set up FRP tunnels for SSH access to remote servers and Google Colab instances.

## Files
- `~/skills/setup-frp-tunnel.sh` - Main FRP tunnel setup script

## Usage

### Server Setup (One-time)
```bash
# Set up FRP server on your VPS/cloud server
~/skills/setup-frp-tunnel.sh server
```

### Client Setup
```bash
# Connect your local machine
~/skills/setup-frp-tunnel.sh client SERVER_IP TOKEN [PORT]

# Example
~/skills/setup-frp-tunnel.sh client 34.123.45.67 abc123 6001
```

### Google Colab Setup
```bash
# Set up tunnel for Google Colab
~/skills/setup-frp-tunnel.sh colab SERVER_IP TOKEN [PORT]

# Example  
~/skills/setup-frp-tunnel.sh colab 34.123.45.67 abc123 6001
```

### Help
```bash
~/skills/setup-frp-tunnel.sh --help
```

## What This Does

### Server Mode
- Installs frp-tunnel package
- Configures FRP server (frps)
- Sets up authentication token
- Provides connection details

### Client Mode
- Installs frp-tunnel package
- Connects to FRP server
- Creates SSH tunnel
- Enables remote access

### Colab Mode
- Installs frp-tunnel in Colab
- Sets up SSH server in Colab
- Creates tunnel to your FRP server
- Enables SSH access to Colab

## Requirements

### Server Requirements
- Linux VPS (Google Cloud, AWS, DigitalOcean, etc.)
- Open ports: 6001-6010 and 7000
- Python 3.7+

### Client Requirements
- Any computer with SSH
- Python 3.7+
- Internet connection

### Firewall Setup
```bash
# Google Cloud
gcloud compute firewall-rules create frp-tunnel --allow tcp:6001-6010,tcp:7000

# AWS
aws ec2 authorize-security-group-ingress --group-id sg-xxxxx --protocol tcp --port 6001-6010 --cidr 0.0.0.0/0
```

## Use Cases

### 1. Access Google Colab Files
```bash
# In Colab
!~/skills/setup-frp-tunnel.sh colab 34.123.45.67 abc123

# On your computer
ssh -p 6001 colab@34.123.45.67
```

### 2. VS Code Remote Development
1. Set up tunnel (above steps)
2. Install "Remote-SSH" extension in VS Code
3. Connect to `colab@SERVER_IP:6001`
4. Code directly in Colab!

### 3. Multiple Connections
```bash
# Colab 1
~/skills/setup-frp-tunnel.sh colab SERVER_IP TOKEN 6001

# Colab 2
~/skills/setup-frp-tunnel.sh colab SERVER_IP TOKEN 6002

# Your laptop
~/skills/setup-frp-tunnel.sh client SERVER_IP TOKEN 6003
```

## Troubleshooting

### Connection Refused
```bash
# Check if server is running
ssh SERVER_IP "ps aux | grep frps"
```

### Permission Denied
```bash
# Make sure you're using the right port
ssh -p 6001 colab@SERVER_IP  # Not port 22!
```

### Token Mismatch
```bash
# Get token from server
ssh SERVER_IP "cat ~/data/frp/frps.ini | grep token"
```

## Features
- ✅ Automatic package installation
- ✅ Multi-mode support (server/client/colab)
- ✅ Port customization
- ✅ Error handling and validation
- ✅ Clear usage instructions
- ✅ Cross-platform support

## Security
- Uses secure token authentication
- Encrypted SSH tunnels
- Configurable ports
- No hardcoded credentials
