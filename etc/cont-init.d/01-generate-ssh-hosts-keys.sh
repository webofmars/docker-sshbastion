#!/bin/sh

if [ -f /etc/firstboot ]; then
    echo "+ generating ssh keys"
    ssh-keygen -A && rm -f /etc/firstboot
fi
