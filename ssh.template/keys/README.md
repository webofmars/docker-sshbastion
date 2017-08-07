Put in this directory all the keys that can be used to ssh to other hosts.
They can be adressed in your ssh config file like this :

```
Host final-target
  Hostname server.example.com
  User john
  RequestTTY yes
  ProxyCommand ssh -o 'ForwardAgent=yes' -W %h:%p jump@jumpbox 'ssh-add /ssh/keys/keyname'
```