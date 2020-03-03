default:	
	docker-compose up -d --build 

down:
	docker-compose down
	rm -rf wordpress

ansible_new:
	ansible-playbook --vault-password-file=vault_password wp.yml --extra-vars "initialize_wp=true"

ansible:
	ansible-playbook --vault-password-file=vault_password wp.yml 

stop:
	docker stop $(< docker ps -q)