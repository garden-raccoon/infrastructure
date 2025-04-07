# Full configuration options can be found at https://www.nomadproject.io/docs/configuration

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

server {
  # license_path is required as of Nomad v1.1.1+
  #license_path = "/opt/nomad/license.hclic"
  enabled          = true
  bootstrap_expect = 1
}

consul {
  address = "127.0.0.1:8500"
}
client {
  enabled = true
  servers = ["127.0.0.1"]
  host_volume "data" {
    path = "/home/dos/Desktop/raccoon/infrastructure/data" # path MUST be absolute
    read_only = false
  }
  host_network "raccnet" {
    cidr = "0.0.0.213/24"
  }
}
name = "commodore"
plugin "docker" {
  config {
    volumes {
      enabled      = true
    }
  }
}
