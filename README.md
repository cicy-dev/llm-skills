# 🛠️ LLM Skills Repository

**[English](#english) | [中文](#中文)**

Reusable skills and tools for LLMs - Python package publishing, FRP tunneling, and more automation scripts.

**🔗 GitHub Repository**: https://github.com/cicy-dev/llm-skills

---

## English

### 📋 Available Skills

#### 1. Python Package Publishing Skill
- **Script**: `publish-pip-package.sh`
- **Documentation**: `PUBLISH_PIP_SKILL.md`
- **Function**: Automated Python package publishing to PyPI
- **Usage**: `~/skills/publish-pip-package.sh [project_directory]`

#### 2. FRP Tunnel Setup Skill
- **Script**: `setup-frp-tunnel.sh`
- **Documentation**: `SETUP_FRP_TUNNEL_SKILL.md`
- **Function**: Setup FRP tunnels for SSH remote access
- **Usage**: `~/skills/setup-frp-tunnel.sh [server|client|colab] [parameters]`

### 🚀 How to Use Skills

#### For LLMs:
```bash
# View all available skills
ls ~/skills/

# Use Python package publishing skill
~/skills/publish-pip-package.sh /path/to/python/project

# Use FRP tunnel skill
~/skills/setup-frp-tunnel.sh server
~/skills/setup-frp-tunnel.sh client SERVER_IP TOKEN

# View skill documentation
cat ~/skills/PUBLISH_PIP_SKILL.md
```

#### For Users:
1. Copy needed skill scripts to `~/skills/` directory
2. Ensure scripts have execute permissions: `chmod +x ~/skills/script-name.sh`
3. Create corresponding documentation files explaining usage

### 📁 Skills Directory Structure
```
~/skills/
├── README.md                    # This file
├── list-skills.sh              # Skills discovery tool
├── publish-pip-package.sh       # Python package publishing script
├── PUBLISH_PIP_SKILL.md        # Python package publishing documentation
├── setup-frp-tunnel.sh         # FRP tunnel setup script
├── SETUP_FRP_TUNNEL_SKILL.md   # FRP tunnel setup documentation
└── [other skill files...]
```

### ✨ Skill Features
- **Reusable**: Any LLM can invoke them
- **Standardized**: Unified interface and documentation format
- **Self-contained**: Each skill includes complete functionality and documentation
- **Cross-project**: Can be used across different projects

### 🔧 Adding New Skills
1. Create executable script file
2. Add corresponding `.md` documentation file
3. Update this README.md file
4. Ensure script has proper error handling and help information
5. Commit to GitHub: `git add . && git commit -m "Add new skill" && git push`

### 🌐 Install Skills Locally
```bash
# Clone skills repository
git clone https://github.com/cicy-dev/llm-skills.git ~/skills

# Or update existing skills
cd ~/skills && git pull
```

### 📖 Skill Naming Convention
- Script files: `action-target.sh` (e.g., `publish-pip-package.sh`)
- Documentation files: `ACTION_TARGET_SKILL.md` (e.g., `PUBLISH_PIP_SKILL.md`)
- Function description: Concise and clear, one sentence explanation

---

## 中文

### 📋 可用技能

#### 1. Python 包发布技能
- **脚本**: `publish-pip-package.sh`
- **文档**: `PUBLISH_PIP_SKILL.md`
- **功能**: 自动化发布 Python 包到 PyPI
- **使用**: `~/skills/publish-pip-package.sh [项目目录]`

#### 2. FRP 隧道设置技能
- **脚本**: `setup-frp-tunnel.sh`
- **文档**: `SETUP_FRP_TUNNEL_SKILL.md`
- **功能**: 设置 FRP 隧道实现 SSH 远程访问
- **使用**: `~/skills/setup-frp-tunnel.sh [server|client|colab] [参数]`

### 🚀 如何使用技能

#### 对于 LLM:
```bash
# 查看所有可用技能
ls ~/skills/

# 使用 Python 包发布技能
~/skills/publish-pip-package.sh /path/to/python/project

# 使用 FRP 隧道技能
~/skills/setup-frp-tunnel.sh server
~/skills/setup-frp-tunnel.sh client SERVER_IP TOKEN

# 查看技能文档
cat ~/skills/PUBLISH_PIP_SKILL.md
```

#### 对于用户:
1. 将需要的技能脚本复制到 `~/skills/` 目录
2. 确保脚本有执行权限: `chmod +x ~/skills/script-name.sh`
3. 创建对应的文档文件说明使用方法

### 📁 技能目录结构
```
~/skills/
├── README.md                    # 本文件
├── list-skills.sh              # 技能发现工具
├── publish-pip-package.sh       # Python 包发布脚本
├── PUBLISH_PIP_SKILL.md        # Python 包发布文档
├── setup-frp-tunnel.sh         # FRP 隧道设置脚本
├── SETUP_FRP_TUNNEL_SKILL.md   # FRP 隧道设置文档
└── [其他技能文件...]
```

### ✨ 技能特点
- **可重用**: 任何 LLM 都可以调用
- **标准化**: 统一的接口和文档格式
- **自包含**: 每个技能都包含完整的功能和文档
- **跨项目**: 可在不同项目中使用

### 🔧 添加新技能
1. 创建可执行脚本文件
2. 添加对应的 `.md` 文档文件
3. 更新本 README.md 文件
4. 确保脚本有适当的错误处理和帮助信息
5. 提交到 GitHub: `git add . && git commit -m "Add new skill" && git push`

### 🌐 安装技能到本地
```bash
# 克隆技能仓库
git clone https://github.com/cicy-dev/llm-skills.git ~/skills

# 或更新现有技能
cd ~/skills && git pull
```

### 📖 技能命名规范
- 脚本文件: `action-target.sh` (如: `publish-pip-package.sh`)
- 文档文件: `ACTION_TARGET_SKILL.md` (如: `PUBLISH_PIP_SKILL.md`)
- 功能描述: 简洁明了，一句话说明用途
