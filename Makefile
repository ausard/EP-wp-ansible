ansible_new:
	ansible-playbook --vault-password-file=vault_password wp.yml --extra-vars "initialize_wp=true"

ansible:
	ansible-playbook --vault-password-file=vault_password wp.yml --extra-vars "initialize_wp=false"

stop:
	containers=docker ps -q \
	docker stop containers
