#!/bin/bash
# Skills Discovery Tool
# Usage: ~/skills/list-skills.sh

echo "🛠️  Available LLM Skills"
echo "======================="
echo ""

SKILLS_DIR="$HOME/skills"

if [[ ! -d "$SKILLS_DIR" ]]; then
    echo "❌ Skills directory not found: $SKILLS_DIR"
    exit 1
fi

cd "$SKILLS_DIR"

echo "📁 Skills Directory: $SKILLS_DIR"
echo ""

# List all executable scripts
echo "🚀 Executable Skills:"
for script in *.sh; do
    if [[ -x "$script" && "$script" != "list-skills.sh" ]]; then
        # Get description from script comments
        description=$(head -5 "$script" | grep -E "^#.*:" | head -1 | sed 's/^#[[:space:]]*//')
        if [[ -z "$description" ]]; then
            description="No description available"
        fi
        echo "  • $script - $description"
    fi
done

echo ""

# List documentation files
echo "📖 Documentation:"
for doc in *.md; do
    if [[ -f "$doc" && "$doc" != "README.md" ]]; then
        echo "  • $doc"
    fi
done

echo ""
echo "💡 Usage Examples:"
echo "  ~/skills/publish-pip-package.sh /path/to/project"
echo "  ~/skills/setup-frp-tunnel.sh server"
echo "  ~/skills/setup-frp-tunnel.sh client SERVER_IP TOKEN"
echo "  cat ~/skills/PUBLISH_PIP_SKILL.md"
echo ""
echo "📋 For detailed information: cat ~/skills/README.md"
