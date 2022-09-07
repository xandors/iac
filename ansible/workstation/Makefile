install:
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt install -y ansible | true
	ansible-galaxy collection install community.general

run:
	ansible-playbook -i inventory ansible.yml
