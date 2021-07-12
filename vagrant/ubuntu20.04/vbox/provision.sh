#!/bin/bash

set -ex

export PATH=/usr/local/bin:${PATH}

[[ ! -z ${APP_USER} ]] || APP_USER=vagrant

if [[ -z "$(id ${APP_USER})" ]]; then
    groupadd --gid 9999 ${APP_USER} || :
    adduser -s /bin/bash --uid 9999 --gid 9999 ${APP_USER}
    usermod -aG wheel ${APP_USER}
    usermod -aG tty ${APP_USER}
    [[ -z "$(id ubuntu)" ]] || usermod -aG ${APP_USER} ubuntu
    [[ -z "$(id vagrant)" ]] || usermod -aG ${APP_USER} vagrant
    mkdir -p /home/${APP_USER}/.ssh
    if [[ -z "$(grep "${APP_USER} ALL=(ALL) NOPASSWD: ALL" /etc/sudoers)" ]]; then
        echo -e "\n${APP_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    fi
fi

[[ ! -d /tmp/${APP_USER} ]] || cp -rT /tmp/${APP_USER} /home/${APP_USER}
[[ ! -f /home/${APP_USER}/.bashrc ]] || cp /home/${APP_USER}/.bashrc /root/.bashrc
[[ ! -f /home/${APP_USER}/.bash_aliases ]] || cp /home/${APP_USER}/.bash_aliases /root/.bash_aliases


if [[ ! -f /vagrant_authorized_keys ]] && [[ -f /tmp/vagrant_authorized_keys ]]; then
    mv /tmp/vagrant_authorized_keys /vagrant_authorized_keys
fi

if [[ -z "$(grep "vagrant" /home/${APP_USER}/.ssh/authorized_keys)" ]]; then
  if [[ -f /vagrant_authorized_keys ]]; then
    echo -e "\n" >> /home/${APP_USER}/.ssh/authorized_keys
    cat /vagrant_authorized_keys >> /home/${APP_USER}/.ssh/authorized_keys
  fi
fi

if [[ -f /tmp/host_authorized_keys ]] && [[ ! -f /tmp/host_authorized_keys.done ]]; then
  echo -e "\n" >> /home/${APP_USER}/.ssh/authorized_keys
  cat /tmp/host_authorized_keys >> /home/${APP_USER}/.ssh/authorized_keys
  mv /tmp/host_authorized_keys /tmp/host_authorized_keys.done
fi

cat /home/${APP_USER}/.ssh/authorized_keys

cat << EOF > /home/${APP_USER}/.ssh/config
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile /dev/null
EOF

touch /home/${APP_USER}/.vagrantvm
chmod 700 /home/${APP_USER}
chmod 700 /home/${APP_USER}/.ssh
chmod 600 /home/${APP_USER}/.ssh/id_rsa
chmod 600 /home/${APP_USER}/.ssh/authorized_keys
find . -mindepth 1 -type d -not -wholename '*/dev' \
    -not -path '*/dev/*' -print0 \
    | xargs -0 chown -R ${APP_USER}:${APP_USER}

if [[ ! -f /home/${APP_USER}/.dev-package-installed ]]; then
  apt-get update
  apt-get install -y \
    avahi-daemon \
    curl \
    wget \
    python3.8-venv \
    python3-pip
  touch /home/${APP_USER}/.dev-package-installed
fi

if [[ ! -f /home/${APP_USER}/.pip-package-installed ]]; then
  pip3 install --upgrade pip
  pip3 install wheel
  touch /home/${APP_USER}/.pip-package-installed
fi
