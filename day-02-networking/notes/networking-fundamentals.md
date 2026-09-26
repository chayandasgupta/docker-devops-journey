# Networking Fundamentals

## 1. Core Mental Model

A network communication can be thought of as:

    WHO?
      ↓
    IP Address

    WHICH SERVICE?
      ↓
    Port

    HOW?
      ↓
    Protocol

Example:

    192.168.0.107:3000

    192.168.0.107 → machine/interface
    3000          → service

---

# 2. IPv4

IPv4 address contains 32 bits.

Example:

    192.168.0.107

Four octets:

    192 . 168 . 0 . 107

Each octet:

    0 - 255

---

# 3. Private IP

Private IPv4 ranges:

    10.0.0.0/8
    172.16.0.0/12
    192.168.0.0/16

Example:

    192.168.0.107

is a private/local network address.

---

# 4. CIDR

CIDR:

    IP/prefix

Example:

    192.168.0.0/24

IPv4:

    32 bits

`/24` means:

    24 bits → network
    8 bits  → host

Therefore:

    2^8 = 256 total addresses

Common IPv4 ranges:

    10.0.0.0/8
    172.16.0.0/12
    192.168.0.0/16

---

# 5. Network Address vs Host Address

Suppose:

    192.168.0.107/24

Network:

    192.168.0.0/24

Host:

    192.168.0.107

Broadcast:

    192.168.0.255

---

# 6. Network Interface

Command:

    ip addr

Example:

    lo
    wlp1s0

`lo`:

    Loopback

`wlp1s0`:

    Wi-Fi interface

Example:

    inet 192.168.0.107/24

means the Wi-Fi interface has that IPv4 address.

---

# 7. Loopback

Loopback allows a machine to communicate with itself.

IPv4:

    127.0.0.1

IPv6:

    ::1

Example:

    Browser
       ↓
    localhost:3000
       ↓
    127.0.0.1:3000
       ↓
    Local application

---

# 8. localhost

`localhost` is a hostname representing the local machine.

Usually:

    localhost → 127.0.0.1

Example:

    localhost:3000

means:

    this machine + port 3000

---

# 9. 127.0.0.1

`127.0.0.1` is a loopback IPv4 address.

It means:

    This machine itself.

It does NOT mean:

    router
    internet
    another computer

---

# 10. 0.0.0.0

When used as a server bind address:

    0.0.0.0

means:

    Listen on all IPv4 interfaces.

Example machine:

    127.0.0.1
    192.168.0.107

Server:

    127.0.0.1:5000

Only localhost connections are accepted through that bind.

Server:

    0.0.0.0:5000

The server listens on all IPv4 interfaces.

Important:

    0.0.0.0
        ↓
    Usually a bind/listen wildcard

It is not normally used as the destination address by clients.

---

# 11. IP vs Port

IP identifies the machine/interface.

Port identifies the service.

Example:

    192.168.0.107:5000

means:

    IP   → 192.168.0.107
    Port → 5000

---

# 12. Common Ports

Examples:

    HTTP  → 80
    HTTPS → 443
    SSH   → 22

Development:

    Next.js → commonly 3000
    API     → commonly 5000
    PostgreSQL → 5432

The exact port depends on the application configuration.

---

# 13. DNS

DNS translates domain names into IP addresses.

Example:

    anandaalo.com
          ↓
        DNS
          ↓
    43.159.57.138

Command:

    ping anandaalo.com

The first line can show:

    PING anandaalo.com (43.159.57.138)

This demonstrates that the domain was resolved to an IP.

---

# 14. ping

`ping` uses ICMP.

Example:

    ping 127.0.0.1

Typical response:

    64 bytes from 127.0.0.1:
    icmp_seq=1
    ttl=64
    time=0.042 ms

Meaning:

    icmp_seq → request sequence number
    ttl      → Time To Live
    time     → round-trip time

---

# 15. ping Does Not Mean HTTP

This is important.

`ping`:

    ICMP
      ↓
    IP

`curl`:

    HTTP
      ↓
    TCP
      ↓
    IP

Therefore:

    ping fails
    curl works

can happen normally.

Reason:

    ICMP may be blocked
    while TCP port 80/443 is allowed.

---

# 16. curl

Example:

    curl -I https://example.com

`curl` sends an HTTP request.

`-I` requests response headers.

Example:

    HTTP/1.1 403 Forbidden
    Server: nginx
    Content-Type: text/html

This means the HTTP server responded.

It does not mean the network failed.

---

# 17. HTTP Status Codes

Common:

    200 → OK
    201 → Created
    400 → Bad Request
    401 → Unauthorized
    403 → Forbidden
    404 → Not Found
    500 → Internal Server Error

---

# 18. 403 Example

Suppose:

    curl -I https://anandaalo.com

returns:

    HTTP/1.1 403 Forbidden

Interpretation:

    DNS resolution        → successful
    TCP connection        → successful
    HTTPS/HTTP request    → reached server
    HTTP access decision  → denied

Therefore 403 is an application/HTTP-level response.

---

# 19. TCP

TCP is a transport-layer protocol.

Responsibilities include:

- Connection establishment
- Reliable delivery
- Ordered delivery
- Retransmission
- Port-based communication

Simplified handshake:

    Client → SYN
    Server → SYN-ACK
    Client → ACK

---

# 20. HTTP over TCP

For normal HTTP/1.1 or HTTP/2 over TCP:

    Application
        ↓
    HTTP
        ↓
    TCP
        ↓
    IP
        ↓
    Network

Example:

    curl https://example.com
             ↓
    HTTP request
             ↓
    TCP connection
             ↓
    Destination IP
             ↓
    Network
             ↓
    Server

---

# 21. IP Layer

IP is responsible for addressing and routing packets.

Example:

    Source:

        192.168.0.107

    Destination:

        43.159.57.138

---

# 22. Network Interface Example

Example output:

    1: lo:
        inet 127.0.0.1/8

    2: wlp1s0:
        inet 192.168.0.107/24

Interpretation:

    lo
      → local machine communication

    wlp1s0
      → Wi-Fi network communication

---

# 23. Important Difference

    127.0.0.1
        ↓
    Local machine only

    192.168.0.107
        ↓
    This machine on local network

    Public IP
        ↓
    Internet-facing address

---

# 24. Server Binding

Suppose an application runs on port 5000.

Binding:

    127.0.0.1:5000

means:

    listen on localhost only

Binding:

    0.0.0.0:5000

means:

    listen on all IPv4 interfaces

---

# 25. Docker Connection

Inside a container:

    127.0.0.1

means:

    The container itself.

Therefore an application inside Docker often needs:

    0.0.0.0:3000

rather than:

    127.0.0.1:3000

Then Docker port publishing can expose it:

    Host:3000
        ↓
    Container:3000

Example:

    docker run -p 3000:3000 app

---

# 26. Useful Commands

Show network interfaces:

    ip addr

Show routing table:

    ip route

Test local networking:

    ping 127.0.0.1

Resolve and ping domain:

    ping example.com

Check HTTP headers:

    curl -I https://example.com

Show listening TCP ports:

    ss -lnt

Show listening TCP/UDP sockets with processes:

    ss -lntup

---

# 27. Mental Model

When opening:

    https://example.com

think:

    example.com
        ↓
    DNS
        ↓
    IP address
        ↓
    TCP connection
        ↓
    Port 443
        ↓
    HTTPS
        ↓
    Web server
        ↓
    HTTP response

---

# 28. Most Important Things to Remember

    IP     → Which machine/interface?

    Port   → Which service?

    DNS    → Domain → IP

    TCP    → Reliable transport

    HTTP   → Application communication

    ICMP   → Network diagnostic/control messages

    127.0.0.1 → This machine

    localhost → Local machine hostname

    0.0.0.0 → All IPv4 interfaces when binding

    /24    → 24 network bits

    ping   → ICMP test

    curl   → HTTP/HTTPS client

    ip addr → Network interfaces and addresses

    ss     → Listening/network sockets

---

# Docker Memory Shortcut

Container networking:

    Container
        ↓
    Application
        ↓
    0.0.0.0:3000
        ↓
    Docker port mapping
        ↓
    Host:3000
        ↓
    Browser
