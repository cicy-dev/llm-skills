#!/bin/bash
# Global Skill: Setup FRP Tunnel for SSH Access
# Usage: ~/skills/setup-frp-tunnel.sh [server|client|colab] [options]
# Author: Created from frp-tunnel project

set -e

COMMAND="$1"
SERVER_IP="$2"
TOKEN="$3"
PORT="${4:-6001}"

show_help() {
    echo "🚀 FRP Tunnel Setup Skill"
    echo "========================"
    echo ""
    echo "Usage:"
    echo "  ~/skills/setup-frp-tunnel.sh server                    # Setup FRP server"
    echo "  ~/skills/setup-frp-tunnel.sh client SERVER_IP TOKEN   # Setup FRP client"
    echo "  ~/skills/setup-frp-tunnel.sh colab SERVER_IP TOKEN    # Setup for Google Colab"
    echo ""
    echo "Examples:"
    echo "  ~/skills/setup-frp-tunnel.sh server"
    echo "  ~/skills/setup-frp-tunnel.sh client 34.123.45.67 abc123"
    echo "  ~/skills/setup-frp-tunnel.sh colab 34.123.45.67 abc123"
    echo ""
    echo "What this does:"
    echo "  • Installs frp-tunnel package"
    echo "  • Sets up SSH tunneling via FRP"
    echo "  • Enables remote access to servers/Colab"
}

if [[ "$COMMAND" == "--help" || "$COMMAND" == "-h" || -z "$COMMAND" ]]; then
    show_help
    exit 0
fi

echo "🚀 FRP Tunnel Setup"
echo "=================="

# Install frp-tunnel if not available
if ! command -v frp-tunnel &> /dev/null; then
    echo "📦 Installing frp-tunnel..."
    pip install frp-tunnel
    echo "✅ frp-tunnel installed"
else
    echo "✅ frp-tunnel already available"
fi

case "$COMMAND" in
    "server")
        echo ""
        echo "🖥️  Setting up FRP server..."
        echo "This will configure your server to accept FRP connections."
        echo ""
        frp-tunnel setup
        echo ""
        echo "✅ FRP server setup complete!"
        echo "📋 Next steps:"
        echo "  1. Note down your server IP and token"
        echo "  2. Open firewall ports 6001-6010 and 7000"
        echo "  3. Use the IP and token for client connections"
        ;;
        
    "client")
        if [[ -z "$SERVER_IP" || -z "$TOKEN" ]]; then
            echo "❌ Error: SERVER_IP and TOKEN required for client setup"
            echo "Usage: ~/skills/setup-frp-tunnel.sh client SERVER_IP TOKEN [PORT]"
            exit 1
        fi
        
        echo ""
        echo "💻 Setting up FRP client..."
        echo "Server: $SERVER_IP"
        echo "Port: $PORT"
        echo ""
        frp-tunnel client --server "$SERVER_IP" --token "$TOKEN" --port "$PORT"
        echo ""
        echo "✅ FRP client setup complete!"
        echo "📋 You can now SSH with:"
        echo "  ssh -p $PORT user@$SERVER_IP"
        ;;
        
    "colab")
        if [[ -z "$SERVER_IP" || -z "$TOKEN" ]]; then
            echo "❌ Error: SERVER_IP and TOKEN required for Colab setup"
            echo "Usage: ~/skills/setup-frp-tunnel.sh colab SERVER_IP TOKEN [PORT]"
            exit 1
        fi
        
        echo ""
        echo "🔬 Setting up FRP for Google Colab..."
        echo "Server: $SERVER_IP"
        echo "Port: $PORT"
        echo ""
        frp-tunnel colab --server "$SERVER_IP" --token "$TOKEN" --port "$PORT"
        echo ""
        echo "✅ Colab FRP setup complete!"
        echo "📋 You can now SSH to Colab with:"
        echo "  ssh -p $PORT colab@$SERVER_IP"
        echo ""
        echo "💡 Pro tips:"
        echo "  • Use VS Code Remote-SSH extension"
        echo "  • Access Colab files directly"
        echo "  • Run git commands in Colab"
        ;;
        
    *)
        echo "❌ Unknown command: $COMMAND"
        echo ""
        show_help
        exit 1
        ;;
esac

echo ""
echo "🎉 FRP Tunnel setup complete!"
echo "📖 For more help: frp-tunnel --help"
