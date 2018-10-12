#!/usr/bin/env bash


ANSIBLE_VERSION=${ansible_version}


yum_makecache_retry() {
  tries=0
  until [ \$${tries} -ge 5 ]
  do
    yum makecache && break
    let tries++
    sleep 1
  done
}


if [ ! "$(which ansible-playbook)" ]; then

      yum -y install ca-certificates nss
      yum clean all
      rm -rf /var/cache/yum
      yum_makecache_retry
      yum -y install epel-release
      # One more time with EPEL to avoid failures
      yum_makecache_retry

      yum -y install python-pip PyYAML python-jinja2 python-httplib2 python-keyczar python-paramiko git
      # If python-pip install failed and setuptools exists, try that

      if [ -z "$(which pip)" ] && [ -z "$(which easy_install)" ]; then
        yum -y install python-setuptools
        easy_install pip
      elif [ -z "$(which pip)" ] && [ -n "$(which easy_install)" ]; then
        easy_install pip
      fi

      # Install passlib for encrypt
      yum -y groupinstall "Development tools"
      yum -y install python-devel MySQL-python sshpass libffi-devel openssl-devel && pip install pyrax pysphere boto passlib dnspython

      # Install Ansible module dependencies
      yum -y install bzip2 file findutils git gzip hg svn sudo tar which unzip xz zip libselinux-python
      [ -n "$(yum search procps-ng)" ] && yum -y install procps-ng || yum -y install procps



      pip install -q six --upgrade
      mkdir -p /etc/ansible/
      printf "%s\n" "[local]" "localhost" > /etc/ansible/hosts


      if [ -z "$ANSIBLE_VERSION" ]; then
        pip install -q ansible
      else
        pip install -q ansible=="$ANSIBLE_VERSION"
      fi


      if [ -f /etc/centos-release ] || [ -f /etc/redhat-release ] || [ -f /etc/oracle-release ] || [ -f /etc/system-release ]; then
        # Fix for pycrypto pip / yum issue
        # https://github.com/ansible/ansible/issues/276

            if  ansible --version 2>&1  | grep -q "AttributeError: 'module' object has no attribute 'HAVE_DECL_MPZ_POWM_SEC'" ; then
              echo 'WARN: Re-installing python-crypto package to workaround ansible/ansible#276'
              echo 'WARN: https://github.com/ansible/ansible/issues/276'
              pip uninstall -y pycrypto
              yum erase -y python-crypto
              yum install -y python-crypto python-paramiko
            fi
      fi
fi



