# mcannounce

mcannounce is a tool that will announce a minecraft server to the LAN.

Modeled after the python implementation of a similar minecraft server announcement script described at https://void7.net/advertising-linux-minecraft-servers-to-the-lan/, 
mcannounce broadcasts one or more server announcements to the local network.

NOTE: This application does not currently run on Windows, as Crystal doesn't support Windows yet. Windows support is coming though, see https://github.com/crystal-lang/crystal/issues/5430.


## Installation

You can either donwload and run a pre-built application binary, or build it yourself.

### Download a pre-built binary
1. Download either the macos or linux binary from github. Windows is currently not supported, as Crystal doesn't support Windows yet. Windows support is coming though, see https://github.com/crystal-lang/crystal/issues/5430.

### Build mcannounce yourself
1. Clone the `mcannounce` repo.
2. `cd mcannounce`
3. `crystal build mcannounce.cr`


## Usage

1. Write a file named `mcannounce.yml` (all lower case) in the same directory as the mcannounce application binary.
2. Run the `mcannounce` binary.
3. When you're done running the application, break out of it by pressing <ctrl+c>.

Example:

```
~ ❯ cat mcannounce.yml
broadcast_ip: 255.255.255.255
broadcast_port: 4445
servers:
  - name: Local Network - Creative
    port: 25565
  - name: Local Network - Survival (easy)
    port: 25566
  - name: Local Network - Survival (standard)
    port: 25567
  - name: Local Network - Survival (hard)
    port: 25568
~ ❯ ./mcannounce
Announcing the following Minecraft servers to LAN:
********************************************************************************
server: Local Network - Creative
port: 25565
********************************************************************************
server: Local Network - Survival (easy)
port: 25566
********************************************************************************
server: Local Network - Survival (standard)
port: 25567
********************************************************************************
server: Local Network - Survival (hard)
port: 25568
^C
```

## Contributing

1. Fork it (<https://github.com/your-github-user/mcannounce/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## Contributors

- [David Ellis](https://github.com/davidkellis) - creator and maintainer
