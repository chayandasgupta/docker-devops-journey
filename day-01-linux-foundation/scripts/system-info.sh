```bash
#!/bin/bash

echo "=============================="
echo " Linux System Inspector"
echo "=============================="
echo

echo "User: $(whoami)"
echo "Hostname: $(hostname)"
echo "Current Directory: $(pwd)"
echo "Home Directory: $HOME"
echo "Shell: $SHELL"
echo "Kernel: $(uname -r)"
echo "Architecture: $(uname -m)"
echo

echo "CPU:"
lscpu | grep "Model name"
echo

echo "Memory:"
free -h
echo

echo "Disk:"
df -h /
echo

echo "Running Processes:"
ps aux
```
