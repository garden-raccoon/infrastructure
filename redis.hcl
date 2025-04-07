
job "redis" {
  datacenters = ["dc1"]

  group "redis" {
    count = 1

    network {
      port "db" {
        static = 6379
      }
      mode = "host"
    }

    task "redis" {
      driver = "docker"

      config {
        image = "redis:latest"
        ports = ["db"]
      }

      resources {
        cpu    = 256
        memory = 256
      }

      service {
        name = "redis"
        port = "db"

        check {
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
