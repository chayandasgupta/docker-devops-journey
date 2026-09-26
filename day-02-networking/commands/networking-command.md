```text
# Networking Commands Cheatsheet

## 1. Network Interfaces

### Show all network interfaces and IP addresses

    ip addr

Short form:

    ip a

**Use:**
- Network interfaces দেখার জন্য
- IPv4/IPv6 address দেখার জন্য
- `lo`, Wi-Fi, Ethernet interface identify করার জন্য


## 2. Routing

### Show routing table

    ip route

**Use:**
- Default gateway দেখার জন্য
- কোন network কোন interface দিয়ে যাবে বুঝতে


## 3. Ping

### Test localhost

    ping 127.0.0.1

**Tests:**
- Local networking stack
- Loopback interface
- ICMP communication

### Ping a domain

    ping example.com

**Checks:**
1. DNS resolution
2. ICMP connectivity/reply

> `ping` fail করলেই server down — এটা নিশ্চিতভাবে বলা যায় না। ICMP block করা থাকতে পারে.


## 4. curl

### Check HTTP/HTTPS response headers

    curl -I https://example.com

**Use:**
- HTTP/HTTPS server response check করার জন্য
- HTTP status code দেখার জন্য
- Response headers দেখার জন্য

Example:

    HTTP/1.1 200 OK

or:

    HTTP/1.1 403 Forbidden

### Make a normal HTTP request

    curl https://example.com


## 5. Listening Ports

### Show listening TCP ports

    ss -lnt

Options:

    -l → listening
    -n → numeric addresses/ports
    -t → TCP

### Show listening TCP/UDP ports with processes

    ss -lntup

Options:

    -l → listening
    -n → numeric
    -t → TCP
    -u → UDP
    -p → process information

### Check a specific port

    ss -lnt | grep 3000

Example:

    ss -lnt | grep 5000


## 6. DNS

### Resolve a hostname

    getent hosts example.com

Concept:

    example.com
         ↓
        DNS
         ↓
    IP address

Example:

    anandaalo.com
         ↓
    43.159.57.138


## 7. Hostname

### Show current machine hostname

    hostname


## 8. Useful Localhost Tests

### Test a local HTTP server

    curl http://127.0.0.1:3000

or:

    curl http://localhost:3000

### Check whether port 3000 is listening

    ss -lnt | grep 3000

### Check whether port 5000 is listening

    ss -lnt | grep 5000


## 9. Important Addresses

| Address | Meaning |
|---|---|
| `127.0.0.1` | This machine/container |
| `localhost` | Local machine hostname |
| `0.0.0.0` | All IPv4 interfaces when used as a server bind address |
| `192.168.x.x` | Common private/local network IP |


## 10. Important Ports

| Port | Common Use |
|---:|---|
| `22` | SSH |
| `80` | HTTP |
| `443` | HTTPS |
| `3000` | Common development port |
| `5000` | Common API/development port |
| `5432` | PostgreSQL |

> Ports are not permanently tied to applications. These are common/default conventions.


## 11. Protocol Quick Reference

| Protocol | Purpose |
|---|---|
| DNS | Domain name → IP address |
| ICMP | Network diagnostic/control messages |
| TCP | Reliable transport + ports |
| HTTP | Application-level web communication |
| HTTPS | HTTP over TLS |


## 12. Networking Mental Model

    Domain
      ↓
    DNS
      ↓
    IP Address
      ↓
    Port
      ↓
    TCP
      ↓
    HTTP/HTTPS
      ↓
    Application

Example:

    https://example.com
            ↓
          DNS
            ↓
        IP Address
            ↓
        TCP :443
            ↓
          HTTPS
            ↓
        Web Server


## 13. ping vs curl

### ping

    ping
     ↓
    ICMP
     ↓
    IP
     ↓
    Network

Used mainly to test network-level reachability.

### curl

    curl
     ↓
    HTTP/HTTPS
     ↓
    TCP
     ↓
    IP
     ↓
    Network

Used to test HTTP/HTTPS communication.

Therefore:

    ping fails
    +
    curl works

is possible.

The server may block ICMP while allowing TCP/HTTP/HTTPS.


## 14. HTTP Status Codes

| Code | Meaning |
|---:|---|
| `200` | OK |
| `201` | Created |
| `400` | Bad Request |
| `401` | Unauthorized |
| `403` | Forbidden |
| `404` | Not Found |
| `500` | Internal Server Error |

Example:

    HTTP/1.1 403 Forbidden

means the HTTP server received and processed the request but refused access.

It does **not** mean the network connection failed.


## 15. Server Binding

### Bind to localhost

    127.0.0.1:5000

Meaning:

    Listen only on localhost

### Bind to all IPv4 interfaces

    0.0.0.0:5000

Meaning:

    Listen on all available IPv4 interfaces

Example machine:

    127.0.0.1
    192.168.0.107

Server:

    0.0.0.0:5000

The service can potentially be reached through:

    127.0.0.1:5000
    192.168.0.107:5000

subject to firewall and network configuration.


## 16. CIDR Quick Reference

Common private IPv4 ranges:

    10.0.0.0/8
    172.16.0.0/12
    192.168.0.0/16

Example:

    192.168.0.107/24

Network:

    192.168.0.0/24

Broadcast:

    192.168.0.255


## 17. Network Debugging Flow

When an application is not reachable:

    1. Is the application running?
              ↓
    2. Is the expected port listening?
              ↓
    3. What address is it bound to?
              ↓
    4. Can localhost reach it?
              ↓
    5. Can the network reach it?
              ↓
    6. Is a firewall blocking it?
              ↓
    7. Is the application returning an HTTP error?

Useful commands:

    ps aux
    ss -lnt
    ip addr
    ip route
    ping 127.0.0.1
    curl -I http://127.0.0.1:3000


## 18. Docker Connection

Inside a container:

    127.0.0.1

means:

    The container itself

For a containerized web server, commonly:

    0.0.0.0:3000

is used so the application listens on the container's IPv4 interfaces.

Docker port mapping:

    Host:3000
        ↓
    Container:3000

Example:

    docker run -p 3000:3000 my-app

Meaning:

    Host port 3000
           ↓
    Container port 3000


## 19. Most Important Commands

    # Network interfaces
    ip addr

    # Short form
    ip a

    # Routing table
    ip route

    # Local connectivity
    ping 127.0.0.1

    # Domain connectivity / DNS + ICMP
    ping example.com

    # HTTP headers
    curl -I https://example.com

    # HTTP request
    curl https://example.com

    # Listening TCP ports
    ss -lnt

    # Listening TCP/UDP ports + processes
    ss -lntup

    # Check specific port
    ss -lnt | grep 3000

    # DNS/hostname resolution
    getent hosts example.com

    # Hostname
    hostname


## 20. Quick Memory

    IP
    → Which machine/interface?

    Port
    → Which service?

    DNS
    → Domain → IP

    TCP
    → Reliable transport

    HTTP
    → Application communication

    ICMP
    → Network diagnostics

    127.0.0.1
    → This machine/container

    localhost
    → Local machine hostname

    0.0.0.0
    → All IPv4 interfaces when binding

    ip addr
    → Interfaces + IP addresses

    ip route
    → Routing information

    ss
    → Listening/network sockets

    ping
    → ICMP test

    curl
    → HTTP/HTTPS test


## 21. Day 2 Core Mental Model

                         NETWORKING
                              │
              ┌───────────────┼────────────────┐
              ↓               ↓                ↓
             DNS              IP              Port
              │               │                │
        Domain → IP      Which machine?   Which service?
                              │
                              ↓
                             TCP
                              │
                              ↓
                        HTTP / HTTPS
                              │
                              ↓
                         Application


## Remember

    127.0.0.1
    → This machine/container

    192.168.0.107
    → This machine on the local network

    0.0.0.0
    → Listen on all IPv4 interfaces

    IP
    → Identifies the destination machine/interface

    Port
    → Identifies the destination service

    DNS
    → Converts domain name to IP

    TCP
    → Provides reliable transport

    HTTP
    → Defines web/application communication

    ping
    → Tests ICMP connectivity

    curl
    → Tests HTTP/HTTPS communication

    ss
    → Shows listening/network sockets

    ip addr
    → Shows network interfaces and IP addresses

    ip route
    → Shows routing information
```
