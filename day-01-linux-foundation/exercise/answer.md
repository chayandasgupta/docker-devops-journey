# Day 1 — Exercise Answers

## 1. Show the current user

```bash
whoami
```

`whoami` shows the username of the current user.

---

## 2. Show the current directory

```bash
pwd
```

`pwd` means Print Working Directory.

---

## 3. Show the home directory

```bash
echo $HOME
```

`$HOME` contains the current user's home directory.

---

## 4. Show the current shell

```bash
echo $SHELL
```

---

## 5. Show the kernel version

```bash
uname -r
```

---

## 6. Show the system architecture

```bash
uname -m
```

---

## 7. List normal files

```bash
ls
```

---

## 8. List files with detailed information

```bash
ls -l
```

---

## 9. Show hidden files

```bash
ls -la
```

---

## 10. Go to the home directory

```bash
cd ~
```

`~` represents the current user's home directory.

---

## 11. Move one directory up

```bash
cd ..
```

`..` represents the parent directory.

---

## 12. Run a script from the current directory

```bash
./system-info.sh
```

`.` represents the current directory.

---

## 13. Show the PATH

```bash
echo $PATH
```

`PATH` contains directories where the shell searches for executable commands.

---

## 14. Find the location of `ls`

```bash
which ls
```

Example:

```text
/usr/bin/ls
```

---

## 15. Check whether a command is a shell builtin or executable

```bash
type pwd
type ls
```

`pwd` may be a shell builtin, while `ls` is commonly an external executable.

---

## 16. Check running processes

```bash
ps aux
```

---

## 17. Find a specific process

```bash
ps aux | grep sleep
```

The pipe sends the output of `ps aux` to `grep`.

---

## 18. Find a process by name

```bash
pgrep -a sleep
```

---

## 19. Terminate a process

```bash
kill <PID>
```

Forceful termination:

```bash
kill -9 <PID>
```

---

## 20. Explain Program vs Process

A program is a passive set of instructions stored on disk.

A process is a running instance of a program with its own execution state, memory, resources, and PID.

Example:

```bash
sleep 300
```

Here `sleep` is the program being executed, while the running `sleep 300` instance is a process.
