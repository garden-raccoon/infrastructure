job "sms-service" {
  type        = "service"
  group "sms-service-grpc" {
    restart {
      mode     = "delay"
      delay    = "5s"
      interval = "10s"
      attempts = 2
    }
    network {
      port "grpc" {
        static = 9097
      }
    }

    task "sms-service-task" {
      driver = "docker"
      kill_timeout = "15s"
      env {
        DB_HOST = "0.0.0.0"
        DB_PORT = "5432"
         }
        config {
        image = "misnaged/sms-service:latest"
        ports = ["grpc"]
        network_mode = "host"
      }
      service {
        name = "sms-service-grpc"
        port = "grpc"

        tags = [
          "grpc"
        ]

        check {
          type     = "grpc"
          port     = "grpc"
          interval = "2s"
          timeout  = "2s"
        }
        check_restart {
          limit           = 10
          grace           = "10s"
          ignore_warnings = false
        }
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





