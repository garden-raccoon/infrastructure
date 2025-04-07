job "raccoon-db" {
  group "raccoon-db" {
    network {
      port "pg-db" {
        static     = 5432
      }
      mode = "host"
    }


    volume "data" {
      type      = "host"
      source    = "data"
      read_only = false
    }
    task "orders-pg" {
      driver = "docker"
      kill_timeout = "20s"
      env {
        POSTGRES_HOST            = "0.0.0.0"
        POSTGRES_PASSWORD        = "serega123"
        POSTGRES_USER            = "serega"
        POSTGRES_DB              = "raccoon"
        PGDATA                   = "/data/postgres"

      }
      config {
        image = "postgres:latest"
        ports = ["pg-db"]
      }

      resources {
        cpu    = 256
        memory = 256
      }
      logs {
        max_files     = 5
        max_file_size = 15
      }
      volume_mount {
        volume      = "data"
        destination = "/data"
      }
      service {
        name = "postgres-raccoon-db"
        port = "pg-db"

        check {
          type     = "tcp"
          interval = "15s"
          timeout  = "2s"
        }
      }
    }

  }
}

