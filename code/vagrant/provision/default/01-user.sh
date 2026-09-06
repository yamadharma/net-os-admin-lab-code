#!/bin/bash

echo "Provisioning script $0"

username=user
userpassword=123456

encpassword=`openssl passwd -6 ${userpassword}`

if ! id -u "$username" >/dev/null 2>&1
then
    adduser -G wheel -p ${encpassword} ${username}
    homedir=`getent passwd ${username} | cut -d: -f6`
    echo "export PS1='[\u@\H \W]\\$ '" >> ${homedir}/.bashrc
fi


