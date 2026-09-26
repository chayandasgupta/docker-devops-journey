---

## `lab/localhost-server.md`


```md
# Lab — Localhost Server & Network Binding

## Goal

Understand:

- `127.0.0.1`
- `0.0.0.0`
- ports
- listening sockets
- HTTP
- TCP
- `curl`
- server binding

---

# Step 1 — Start a Local HTTP Server

Run:

```bash
python3 -m http.server 5000 --bind 127.0.0.1
```
