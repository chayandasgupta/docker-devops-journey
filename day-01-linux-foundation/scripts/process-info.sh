```bash
#!/bin/bash

echo "=============================="
echo " Linux Process Inspector"
echo "=============================="
echo

echo "Current User:"
whoami
echo

echo "Top Running Processes:"
ps aux --sort=-%cpu | head -11
echo

echo "Memory Usage by Processes:"
ps aux --sort=-%mem | head -11
echo

echo "Current Shell Process:"
ps -p $$ -f
```
