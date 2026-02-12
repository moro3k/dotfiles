#!/bin/bash
# Показывает текущую раскладку клавиатуры (WSL)
# Использует скомпилированный C# exe для быстрого определения (~100ms)
lang=$(/mnt/c/Windows/System32/cmd.exe /C "cd C:\\ && C:\\Users\\ilnur\\kblayout.exe" 2>/dev/null | tr -d '\r\n')
[[ -n "$lang" ]] && echo -n "$lang" || echo -n "??"
