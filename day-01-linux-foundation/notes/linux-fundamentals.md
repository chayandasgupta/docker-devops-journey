# Linux Fundamentals

## 1. Terminal vs Shell

### Terminal

A terminal is the interface through which we interact with the operating system using text commands.

### Shell

A shell interprets the commands we type and executes them.

Common shells:

- `sh`
- `bash`
- `zsh`
- `fish`

For Docker and DevOps learning, Bash and basic `sh` knowledge are important.

---

## 2. Bash

Bash means:

**Bourne Again Shell**

It is both:

- An interactive shell
- A scripting language

Example:

```bash
echo "Hello Linux"
```

---

# 3. Linux Filesystem

Linux uses a hierarchical filesystem that starts from `/`.

```text
/
├── bin
├── boot
├── dev
├── etc
├── home
├── lib
├── media
├── mnt
├── opt
├── proc
├── root
├── run
├── sbin
├── tmp
├── usr
└── var
```

## Important Directories

### `/`

Root directory of the entire filesystem.

```bash
cd /
```

### `/home`

Contains users' home directories.

Example:

```text
/home/chayan
```

### `/etc`

Contains system and application configuration files.

### `/usr`

Contains many user-space programs, libraries and shared resources.

Executables commonly exist in:

```text
/usr/bin
```

### `/var`

Contains changing data such as:

- Logs
- Application data
- Cache
- Spool data

### `/tmp`

Temporary files.

### `/dev`

Device files.

### `/proc`

A virtual filesystem exposing information about processes and the Linux kernel.

---

# 4. Special Path Symbols

## `/`

Root directory.

```bash
cd /
```

## `~`

Current user's home directory.

```bash
cd ~
```

Usually:

```text
~ = /home/<username>
```

## `.`

Current directory.

Example:

```bash
./system-info.sh
```

Means:

```text
Run system-info.sh from the current directory.
```

## `..`

Parent directory.

```bash
cd ..
```

Moves one directory level upward.

Example:

```text
/home/chayan/project
              ↑
             ..
              ↓
/home/chayan
```

---

# 5. Absolute vs Relative Path

## Absolute Path

Starts from `/`.

Example:

```text
/home/chayan/project/file.txt
```

It describes the complete location.

## Relative Path

Starts from the current directory.

Examples:

```text
./file.txt
../file.txt
scripts/system-info.sh
```

---

# 6. `ls`

`ls` lists files and directories.

```bash
ls
```

Detailed listing:

```bash
ls -l
```

Include hidden files:

```bash
ls -a
```

Both:

```bash
ls -la
```

Hidden files usually start with `.`.

---

# 7. File Permissions

Example:

```text
-rwxr-xr--
```

Breakdown:

```text
-   rwx   r-x   r--
│    │     │     │
│    │     │     └── Others
│    │     └──────── Group
│    └────────────── Owner
└─────────────────── File type
```

## Permission Types

```text
r = read
w = write
x = execute
```

Numeric values:

```text
r = 4
w = 2
x = 1
```

Therefore:

```text
rwx = 7
r-x = 5
r-- = 4
```

Example:

```bash
chmod 754 system-info.sh
```

Means:

```text
Owner  → rwx → 7
Group  → r-x → 5
Others → r-- → 4
```

---

# 8. Program vs Process

## Program

A program is a passive set of instructions stored on disk.

Example:

```text
/usr/bin/sleep
```

## Process

A process is a running instance of a program.

Example:

```bash
sleep 300
```

After execution, Linux creates a process with:

- PID
- Memory
- Execution state
- CPU resources
- Other process-related resources

One program can create multiple processes.

---

# 9. Process ID — PID

Every running process has a Process ID.

Example:

```bash
ps aux
```

Output contains a PID column.

You can terminate a process using:

```bash
kill <PID>
```

Forceful termination:

```bash
kill -9 <PID>
```

`kill -9` should not be the default choice because it does not allow the process to perform normal cleanup.

---

# 10. `ps`

`ps` means Process Status.

Basic:

```bash
ps
```

Detailed process listing:

```bash
ps aux
```

Filtering:

```bash
ps aux | grep sleep
```

Here:

```text
ps aux
   ↓
produces process information

|
↓
passes output to grep

grep sleep
↓
shows lines containing "sleep"
```

A cleaner alternative for finding a process:

```bash
pgrep -a sleep
```

---

# 11. Pipe `|`

The pipe sends the output of one command as input to another command.

Example:

```bash
ps aux | grep sleep
```

Conceptually:

```text
Command 1
   ↓
Output
   ↓
  |
   ↓
Command 2
```

---

# 12. Environment Variables

Environment variables store values that programs and shells can use.

Examples:

```bash
echo $HOME
echo $SHELL
echo $PATH
```

`$` means:

```text
Use the value of this variable.
```

---

# 13. `$HOME`

Contains the current user's home directory.

Example:

```bash
echo $HOME
```

Possible result:

```text
/home/chayan
```

Therefore:

```bash
cd ~
```

and:

```bash
cd $HOME
```

normally point to the same location.

---

# 14. `$SHELL`

Shows the user's configured shell.

Example:

```bash
echo $SHELL
```

Possible result:

```text
/bin/bash
```

---

# 15. `$PATH`

`PATH` is an environment variable containing directories where the shell searches for executable commands.

Example:

```bash
echo $PATH
```

Possible output:

```text
/usr/local/bin:/usr/bin:/bin
```

Directories are separated using `:`.

When we type:

```bash
ls
```

the shell searches directories from `PATH`.

Conceptually:

```text
ls
 ↓
/usr/local/bin/ls   ❌
 ↓
/usr/bin/ls         ✅
 ↓
execute
```

Important:

**PATH tells the shell where to search. It does not store the programs itself.**

---

# 16. `/usr/bin`

`/usr/bin` commonly contains executable programs installed by the Linux distribution or package manager.

Examples may include:

```text
ls
grep
cat
git
```

You can check:

```bash
which ls
which git
```

Or:

```bash
type ls
```

Modern Linux systems may use merged directories where:

```text
/bin → /usr/bin
```

Check with:

```bash
ls -ld /bin /usr/bin
```

---

# 17. Built-in Commands

Not every command comes from an executable found through `PATH`.

Some commands are shell builtins.

Check with:

```bash
type pwd
type cd
type echo
type ls
```

For example:

```text
pwd → shell builtin
cd  → shell builtin
```

while:

```text
ls → /usr/bin/ls
```

may point to an executable.

---

# 18. Command Substitution

Command substitution allows the output of a command to be used as a value.

Syntax:

```bash
$(command)
```

Example:

```bash
echo "User: $(whoami)"
```

Another example:

```bash
echo "Kernel: $(uname -r)"
```

This is heavily used in Bash scripts.

---

# 19. System Information Commands

Current user:

```bash
whoami
```

Hostname:

```bash
hostname
```

Current directory:

```bash
pwd
```

Home directory:

```bash
echo $HOME
```

Shell:

```bash
echo $SHELL
```

Kernel:

```bash
uname -r
```

Architecture:

```bash
uname -m
```

CPU:

```bash
lscpu
```

Memory:

```bash
free -h
```

Disk:

```bash
df -h
```

Processes:

```bash
ps aux
```

---

# 20. Docker Connection

Linux fundamentals are directly connected to Docker.

Docker containers use concepts such as:

- Processes
- Filesystems
- Permissions
- Environment variables
- PATH
- `/proc`
- `/dev`
- `/tmp`
- Networking
- Resource limits

A container is not a complete traditional virtual machine. It primarily provides isolation around processes and their related resources.

Understanding Linux makes Docker concepts much easier to understand.
