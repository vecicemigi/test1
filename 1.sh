#!/bin/bash
cd /home/bitnami/ansible-aws
ansible-playbook -i inventory/hosts Playbooks/ansible-aws.yml
