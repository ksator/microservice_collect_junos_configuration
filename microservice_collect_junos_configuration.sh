# cd /
echo "Collect Junos configuration"

if [ -f "inputs/hosts" ]
then
	ansible-playbook playbook.yml -i inputs/hosts
else
	echo "No inventory file found, aborting"
fi

