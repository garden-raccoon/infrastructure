summon:
	MallocNanoZone=0 go run -race $(APP_ENTRY_POINT) summon

start-nomad:
	sudo nomad agent -dev -consul-client-auto-join -config=./assets/nomad_config/

start-consul:
	sudo consul agent -dev -enable-script-checks -ui -config-dir=./assets/consul_config/


migrator:
	./bin/migrate -path=db -database postgresql://serega:serega123@127.0.0.1:5432/raccoon?sslmode=disable up

plan:
	sudo nomad job run -check-index 0 raccoon-db.hcl && sudo nomad job run -check-index 0 redis.hcl

plan-postgres:
	sudo nomad job run -check-index 0 raccoon-db.hcl

rm:
	sudo rm -rf ./data/postgres

plan-services:
	sudo nomad job run -check-index 0 meals-service.hcl && sudo nomad job run -check-index 0 orders.hcl && sudo nomad job run -check-index 0 delivery.hcl && sudo nomad job run -check-index 0 users.hcl && sudo nomad job run -check-index 0 sms.hcl && sudo nomad job run -check-index 0 gateway.hcl

plan-gateway:
		sudo nomad job run -check-index 0 gateway.hcl