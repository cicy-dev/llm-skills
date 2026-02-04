# 🛠️ LLM Skills Repository

这个目录包含可供其他 LLM 使用的技能脚本和工具。

**🔗 GitHub Repository**: https://github.com/cicy-dev/llm-skills

## 📋 可用技能

### 1. Python 包发布技能
- **脚本**: `publish-pip-package.sh`
- **文档**: `PUBLISH_PIP_SKILL.md`
- **功能**: 自动化发布 Python 包到 PyPI
- **使用**: `~/skills/publish-pip-package.sh [项目目录]`

## 🚀 如何使用技能

### 对于 LLM:
```bash
# 查看所有可用技能
ls ~/skills/

# 使用 Python 包发布技能
~/skills/publish-pip-package.sh /path/to/python/project

# 查看技能文档
cat ~/skills/PUBLISH_PIP_SKILL.md
```

### 对于用户:
1. 将需要的技能脚本复制到 `~/skills/` 目录
2. 确保脚本有执行权限: `chmod +x ~/skills/script-name.sh`
3. 创建对应的文档文件说明使用方法

## 📁 技能目录结构
```
~/skills/
├── README.md                    # 本文件
├── publish-pip-package.sh       # Python 包发布脚本
├── PUBLISH_PIP_SKILL.md        # Python 包发布文档
└── [其他技能文件...]
```

## ✨ 技能特点
- **可重用**: 任何 LLM 都可以调用
- **标准化**: 统一的接口和文档格式
- **自包含**: 每个技能都包含完整的功能和文档
- **跨项目**: 可在不同项目中使用

## 🔧 添加新技能
1. 创建可执行脚本文件
2. 添加对应的 `.md` 文档文件
3. 更新本 README.md 文件
4. 确保脚本有适当的错误处理和帮助信息
5. 提交到 GitHub: `git add . && git commit -m "Add new skill" && git push`

## 🌐 安装技能到本地
```bash
# 克隆技能仓库
git clone https://github.com/cicy-dev/llm-skills.git ~/skills

# 或更新现有技能
cd ~/skills && git pull
```

## 📖 技能命名规范
- 脚本文件: `action-target.sh` (如: `publish-pip-package.sh`)
- 文档文件: `ACTION_TARGET_SKILL.md` (如: `PUBLISH_PIP_SKILL.md`)
- 功能描述: 简洁明了，一句话说明用途
