#!/bin/bash
# Создаём временного пользователя если его нет
if ! id claude-temp &>/dev/null; then
    useradd -m -s /bin/bash claude-temp
fi

# Копируем конфигурацию Claude если есть
if [ -d "$HOME/.config/claude" ]; then
    mkdir -p /home/claude-temp/.config
    cp -r "$HOME/.config/claude" /home/claude-temp/.config/
    chown -R claude-temp:claude-temp /home/claude-temp/.config
fi

# Находим путь к claude
CLAUDE_PATH=$(which claude)
if [ -z "$CLAUDE_PATH" ]; then
    CLAUDE_PATH="/root/.npm-global/bin/claude"
fi

# Запускаем от имени обычного пользователя с полным путём
su - claude-temp -c "PATH=/root/.npm-global/bin:$PATH $CLAUDE_PATH --dangerously-skip-permissions $*"