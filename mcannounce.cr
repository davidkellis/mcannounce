require "socket"
require "yaml"

class Config
  property broadcast_ip : String
  property broadcast_port : Int32
  property minecraft_servers_to_advertise : Array(Tuple(String, Int32))

  def initialize(@broadcast_ip, @broadcast_port, @minecraft_servers_to_advertise)
  end
end

CONFIG_FILENAME = "mcannounce.yml"
DEFAULT_CONFIG = Config.new(
  "255.255.255.255",
  4445,
  [
    {"Local Network Host", 25565}
  ]
)

def read_config : Config
  if File.exists?(CONFIG_FILENAME)
    hash = YAML.parse(File.read(CONFIG_FILENAME))
    broadcast_ip = hash["broadcast_ip"].as_s
    broadcast_port = hash["broadcast_port"].as_i
    servers = hash["servers"].as_a.map do |server_hash|
      {server_hash["name"].as_s, server_hash["port"].as_i}
    end
    Config.new(broadcast_ip, broadcast_port, servers)
  end || DEFAULT_CONFIG
rescue e : Exception
  puts "Error reading #{CONFIG_FILENAME}. Will announce default server list instead."
  puts "Error details: #{e.message}"
  puts e.backtrace.join("\n")
  puts
  DEFAULT_CONFIG
end

def main
  config = read_config()

  socket = UDPSocket.new
  socket.broadcast = true
  socket.connect(config.broadcast_ip, config.broadcast_port)

  (puts("Exiting. No servers specified in #{CONFIG_FILENAME}"); exit(1)) if config.minecraft_servers_to_advertise.empty?

  puts "Announcing the following Minecraft servers to LAN:"
  config.minecraft_servers_to_advertise.each do |server|
    puts "*" * 80
    puts "server: #{server[0]}"
    puts "port: #{server[1]}"
  end

  # broadcast the server announcements across the network
  loop do
    config.minecraft_servers_to_advertise.each do |server|
      socket.send("[MOTD]#{server[0]}[/MOTD][AD]#{server[1]}[/AD]")
    end
    sleep(2)
  end

  socket.close

rescue e : Exception
  puts "Unhandled error: #{e.message}"
  puts e.backtrace.join("\n")
end

main
