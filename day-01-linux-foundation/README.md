# Day 01 — Linux Foundation

This day covers the Linux fundamentals required for understanding Docker and containerized environments.

## Topics Covered

- Terminal and Shell
- Bash basics
- Linux filesystem hierarchy
- Absolute and relative paths
- `/`, `~`, `.`, `..`
- File and directory navigation
- `ls` and common options
- Linux file permissions
- Users and groups
- Programs vs Processes
- Process inspection with `ps`
- Process filtering with `grep`
- Process IDs (PID)
- Environment variables
- `$PATH`
- Command lookup
- Basic system information

## Commands Practiced

```bash
pwd
ls
ls -l
ls -la
cd
cd ..
cd ~
whoami
hostname
echo $HOME
echo $SHELL
echo $PATH
uname -r
uname -m
ps aux
grep
which
type
chmod
kill
free -h
df -h
lscpu
```

## Hands-on Projects

### System Inspector

A Bash script that displays basic system information:

- Current user
- Hostname
- Current directory
- Home directory
- Shell
- Kernel version
- Architecture
- CPU information
- Memory usage
- Disk usage
- Running processes

### Process Inspector

A Bash script for inspecting running processes and understanding:

- PID
- Process owner
- CPU usage
- Memory usage
- Running commands

## Key Concepts

### Linux Filesystem

```text
/
├── home
├── etc
├── usr
├── var
├── tmp
├── dev
└── proc
```

### Special Paths

```text
/   → Root directory
~   → Current user's home directory
.   → Current directory
..  → Parent directory
```

### Program vs Process

A program is a passive set of instructions stored on disk.

A process is a running instance of a program with its own execution state, memory, resources, and PID.

### PATH

`PATH` is an environment variable containing directories where the shell searches for executable commands.

Example:

```bash
echo $PATH
```

If `/usr/bin` exists in `PATH`, commands such as `ls` can be found there without typing the full path.

## Docker Connection

These Linux fundamentals are important for Docker because containers rely heavily on:

- Linux processes
- Filesystems
- Permissions
- Environment variables
- PATH
- `/proc`
- `/dev`
- `/tmp`
- Shell commands
- Process isolation

## Day 1 Goal

Understand how Linux works at a basic system level before moving into Docker.

**Next:** Docker fundamentals and container concepts.
