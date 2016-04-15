#!/bin/sh -x -e

PATH_OF_CURRENT_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $PATH_OF_CURRENT_SCRIPT/vagrant_functions.sh
#USER=jss
USER=bahmni

if [ "$#" == "0" ]; then
	FOLDER="app"
else
	FOLDER="$1"
fi

run_in_vagrant -c "sudo rm -rf /opt/bahmni-installer/bahmni-playbooks"

run_in_vagrant -c "sudo mkdir -p /opt/bahmni-installer/"
run_in_vagrant -c "sudo ln -s /bahmni/bahmni-playbooks/ /opt/bahmni-installer/bahmni-playbooks"
run_in_vagrant -c "sudo chown -h ${USER}:${USER} /opt/bahmni-installer/bahmni-playbooks"
run_in_vagrant -c "sudo mkdir -p /opt/bahmni-installer/bin/"

run_in_vagrant -c "sudo rm -rf /opt/bahmni-installer/bin/bahmni"
run_in_vagrant -c "sudo rm -rf /usr/bin/bahmni"
run_in_vagrant -c "sudo ln -s /bahmni/bahmni-package/bahmni-installer/scripts/rpm/bahmni /usr/bin/bahmni"

run_in_vagrant -c "sudo mkdir -p /etc/bahmni-installer/"
run_in_vagrant -c "sudo rm -rf /etc/bahmni-installer/setup.yml"
run_in_vagrant -c "sudo ln -s /bahmni/bahmni-playbooks/dev/setup.yml /etc/bahmni-installer/setup.yml"

run_in_vagrant -c "sudo rm -rf /etc/bahmni-installer/dev"
run_in_vagrant -c "sudo ln -s /bahmni/bahmni-playbooks/dev/dev /etc/bahmni-installer/dev"
run_in_vagrant -c "sudo rm -rf /etc/bahmni-installer/rpm_versions.yml"
run_in_vagrant -c "sudo ln -s /bahmni/bahmni-playbooks/dev/rpm_versions.yml /etc/bahmni-installer/rpm_versions.yml"
run_in_vagrant -c "sudo semodule -i mypol.pp"
