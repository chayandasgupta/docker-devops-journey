# Day 02 — Linux Networking Fundamentals

This day covers the Linux networking concepts required to understand
how applications communicate locally, across a network, and over the internet.

## Topics Covered

- IP address
- IPv4
- Private IP
- CIDR notation
- Network address
- Broadcast address
- Network interface
- Loopback interface
- `127.0.0.1`
- `localhost`
- `0.0.0.0`
- Ports
- TCP
- IP
- HTTP
- DNS
- `ping`
- `curl`
- `ip addr`
- Network stack
- `ping` vs `curl`
- Server binding/listening
- Basic Docker networking connection

---

## 1. What is an IP Address?

An IP address identifies a network interface/device on an IP network.

Example:

    192.168.0.107

This is the local IPv4 address assigned to a machine's Wi-Fi interface.

Important:

    IP → identifies the destination machine/interface
    Port → identifies the application/service

Example:

    192.168.0.107:3000

means:

    IP   = 192.168.0.107
    Port = 3000

---

## 2. Private IPv4 Addresses

Common private IPv4 ranges:

    10.0.0.0/8
    172.16.0.0/12
    192.168.0.0/16

These addresses are commonly used inside private/local networks.

Example:

    192.168.0.107

is a private IP.

It is not directly a public internet address.

---

## 3. CIDR

CIDR notation looks like:

    192.168.0.0/24

The `/24` means the first 24 bits are the network portion.

IPv4 has 32 bits.

Example:

    192.168.0.0/24

Network:

    192.168.0.0

Typical usable host addresses:

    192.168.0.1
    ...
    192.168.0.254

Broadcast:

    192.168.0.255

Other examples:

    10.0.0.0/8
    172.16.0.0/12
    192.168.0.0/16

Larger CIDR prefix = smaller network.

---

## 4. Network Interface

A network interface is the point through which a machine communicates
with a network.

Check interfaces:

    ip addr

Example:

    lo
    wlp1s0

`lo`:

    Loopback interface

`wlp1s0`:

    Wi-Fi interface

Example:

    wlp1s0
        inet 192.168.0.107/24

This means the Wi-Fi interface has:

    IP      = 192.168.0.107
    Network = 192.168.0.0/24

---

## 5. Loopback Interface

The loopback interface allows a machine to communicate with itself.

IPv4 loopback:

    127.0.0.1

IPv6 loopback:

    ::1

Example:

    App A
      ↓
    127.0.0.1:5000
      ↓
    App B

Both applications are running on the same machine.

No Wi-Fi or router is required for this communication.

---

## 6. localhost

`localhost` is a hostname that refers to the local machine.

Commonly:

    localhost → 127.0.0.1

Example:

    http://localhost:3000

is commonly equivalent to:

    http://127.0.0.1:3000

Important:

`localhost` means "this machine", not another machine.

---

## 7. 127.0.0.1 vs Local Network IP

Example machine:

    lo
      127.0.0.1

    wlp1s0
      192.168.0.107

These represent different networking scopes.

    127.0.0.1
        ↓
    This machine only

    192.168.0.107
        ↓
    This machine on the local network

Example:

    Laptop → 192.168.0.107:5000

Another device on the same network can potentially connect to it,
if the service is listening on that interface and firewall/network
rules allow it.

---

## 8. 0.0.0.0

`0.0.0.0` has an important meaning when a server binds/listens.

It means:

    Listen on all available IPv4 interfaces.

Suppose the machine has:

    127.0.0.1
    192.168.0.107

Server:

    127.0.0.1:5000

means:

    Local machine → allowed
    Other network devices → not reachable through 192.168.0.107

Server:

    0.0.0.0:5000

means:

    Listen on all IPv4 interfaces

So the service can potentially be reached through:

    127.0.0.1:5000
    192.168.0.107:5000

assuming firewall and other network rules allow it.

Important:

`0.0.0.0` is normally used as a server bind/listen address.
It is not the normal address a client uses to connect to a server.

---

## 9. Ports

An IP address identifies the machine/interface.

A port identifies the service/application.

Example:

    127.0.0.1:3000

    127.0.0.1 → machine
    3000       → service

Multiple services can run on the same machine using different ports.

Example:

    Next.js → 3000
    API     → 5000
    Database → 5432

---

## 10. Networking Stack

A simplified networking model:

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

    App A
      ↓
    HTTP request
      ↓
    TCP connection :5000
      ↓
    IP destination 127.0.0.1
      ↓
    Loopback interface
      ↓
    App B

Responsibilities:

    HTTP → application-level communication
    TCP  → reliable transport + ports
    IP   → addressing and routing
    Network → actual network technology/link

---

## 11. HTTP

HTTP is an application-layer protocol.

Example:

    GET /users HTTP/1.1
    Host: 127.0.0.1:5000

HTTP defines things such as:

    GET
    POST
    PUT
    PATCH
    DELETE

and status codes such as:

    200 OK
    201 Created
    400 Bad Request
    401 Unauthorized
    403 Forbidden
    404 Not Found
    500 Internal Server Error

---

## 12. TCP

TCP is a transport-layer protocol.

TCP provides:

- Connection-oriented communication
- Reliable delivery
- Ordered data
- Retransmission
- Port-based communication

A simplified TCP connection establishment:

    Client → SYN
    Server → SYN-ACK
    Client → ACK

After that, application data can be exchanged.

---

## 13. DNS

DNS translates domain names into IP addresses.

Example:

    anandaalo.com
          ↓
    DNS lookup
          ↓
    43.159.57.138

So when running:

    ping anandaalo.com

the system first resolves:

    anandaalo.com → 43.159.57.138

Then the network communication can happen using that IP.

---

## 14. ping

`ping` uses ICMP to test network reachability.

Example:

    ping 127.0.0.1

Possible output:

    64 bytes from 127.0.0.1:
    icmp_seq=1
    ttl=64
    time=0.042 ms

Meaning:

    64 bytes
        → ICMP response payload

    icmp_seq=1
        → sequence number

    ttl=64
        → remaining Time To Live

    time=0.042 ms
        → round-trip time

---

## 15. ping localhost

Command:

    ping 127.0.0.1

This tests the local networking stack through the loopback interface.

It does NOT test:

    Internet connection
    Wi-Fi connection
    Router connectivity

It mainly tests local IP/ICMP networking.

---

## 16. ping a Domain

Example:

    ping anandaalo.com

Output:

    PING anandaalo.com (43.159.57.138)

This tells us DNS resolution worked:

    anandaalo.com
          ↓
    43.159.57.138

If no `64 bytes from ...` reply appears, it does NOT automatically mean
the server is down.

The server or network may block ICMP.

---

## 17. curl

`curl` can be used to make HTTP requests.

Example:

    curl -I https://anandaalo.com

`-I` requests response headers.

Example response:

    HTTP/1.1 403 Forbidden
    Server: nginx/1.24.0 (Ubuntu)
    Content-Type: text/html

This proves that the HTTP server responded.

---

## 18. ping vs curl

These test different layers.

ping:

    Application
        ↓
    ICMP
        ↓
    IP
        ↓
    Network

curl:

    Application
        ↓
    HTTP
        ↓
    TCP
        ↓
    IP
        ↓
    Network

Therefore:

    ping fails
    +
    curl works

does NOT necessarily mean the server is unreachable.

The server may simply block ICMP while allowing HTTP/HTTPS.

---

## 19. Understanding a 403 Response

Example:

    HTTP/1.1 403 Forbidden

This means:

    Request reached the HTTP server
    ↓
    Server processed the request
    ↓
    Server refused access
    ↓
    403 response

So:

    DNS       → working
    TCP/HTTPS → working
    HTTP      → working
    Access    → denied

A 403 is an HTTP-level response, not a network connectivity failure.

---

## 20. Server Binding

A server must listen on an address and port.

Example:

    127.0.0.1:5000

means:

    Listen only on localhost.

Example:

    0.0.0.0:5000

means:

    Listen on all IPv4 interfaces.

This distinction becomes very important in Docker.

---

## 21. Docker Connection

Inside a Docker container:

    127.0.0.1

means:

    The container itself.

It does NOT automatically mean the host machine.

For a server inside a container, applications commonly need to listen on:

    0.0.0.0:3000

instead of only:

    127.0.0.1:3000

Then Docker can publish the port:

    Host:3000
        ↓
    Container:3000

Example:

    docker run -p 3000:3000 my-app

Meaning:

    Host port 3000
          ↓
    Container port 3000

---

# Key Mental Model

Always think:

    Domain
       ↓
    DNS
       ↓
    IP Address
       ↓
    Port
       ↓
    Protocol
       ↓
    Application

Example:

    https://anandaalo.com
             ↓
    DNS → 43.159.57.138
             ↓
    HTTPS → TCP port 443
             ↓
    HTTP request
             ↓
    Nginx
             ↓
    HTTP response

---

# Important Commands

    ip addr
    ping 127.0.0.1
    ping example.com
    curl -I https://example.com
    ss -lnt
    hostname
    ip route

---

# Day 2 Goal

By the end of this day, I should understand:

1. What an IP address is
2. What a network interface is
3. What 127.0.0.1 means
4. What localhost means
5. What 0.0.0.0 means
6. What a port is
7. What CIDR means
8. How DNS resolves domains
9. What ping does
10. What curl does
11. Difference between ICMP and HTTP
12. Basic TCP/IP flow
13. Server binding/listening
14. Why these concepts matter in Docker
