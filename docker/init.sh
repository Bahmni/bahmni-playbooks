#!/bin/sh

case $@ in
    setup-containers)
        docker network create --subnet=172.0.0.1/24 bahmni

        docker run -itd --privileged --name bahmni-emr -h bahmni-emr --net bahmni centos:6.6 bash
        docker run -itd --privileged --name bahmni-erp -h bahmni-erp --net bahmni centos:6.6 bash
        docker run -itd --privileged --name bahmni-lab -h bahmni-lab --net bahmni centos:6.6 bash
        docker run -itd --privileged --name mysql -h mysql --net bahmni centos:6.6 bash
        docker run -itd --privileged --name pgsql -h pgsql --net bahmni centos:6.6 bash
        ;;

    create-images)
        docker commit bahmni-emr bahmni/bahmni-emr
        docker commit bahmni-erp bahmni/bahmni-erp
        docker commit bahmni-lab bahmni/bahmni-lab
        docker commit mysql bahmni/mysql
        docker commit pgsql bahmni/pgsql
        ;;
        
    delete-containers)
        docker rm -f bahmni-emr
        docker rm -f bahmni-erp
        docker rm -f bahmni-lab
        docker rm -f mysql
        docker rm -f pgsql
        ;;

    install)
        ansible-playbook -i docker/inventory --extra-vars=@docker/setup.yml --extra-vars=@docker/rpm_versions.yml all-docker.yml -vvvv
        ;;
    *)
        echo "Invalid option";
        echo "Available options : setup-containers, delete-containers, install";
        ;;
esac
