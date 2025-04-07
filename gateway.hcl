job "api-gateway" {
  type        = "service"
  group "api-gateway-http" {
    restart {
      mode     = "delay"
      delay    = "5s"
      interval = "10s"
      attempts = 2
    }
    network {
      port "http" {
        static = 8080
      }
    }

    task "api-gateway-task" {
      driver = "docker"
      kill_timeout = "15s"
      env {
        DB_HOST = "0.0.0.0"
        DB_PORT = "5432"
         }
        config {
        image = "misnaged/api-gateway:latest"
        ports = ["http"]
        network_mode = "host"
      }
      service {
        name = "api-gateway-http"
        port = "http"

        tags = [
          "http"
        ]

        # check {
        #   type     = "http"
        #   path     = "/health"
        #   interval = "2s"
        #   timeout  = "2s"
        # }
        # check_restart {
        #   limit           = 10
        #   grace           = "10s"
        #   ignore_warnings = false
        # }
      }
      resources {
        cpu    = 256
        memory = 256
      }
      logs {
        max_files     = 5
        max_file_size = 15
      }
    }

  }
}





