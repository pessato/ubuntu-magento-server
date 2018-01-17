Install nginx module - http://www.justindhoffman.com/project/nginx-webmin-module ...Can do manullay for now

Install composer

# SSH KEY
https://confluence.atlassian.com/bitbucket/set-up-ssh-for-git-728138079.html

```
ssh-keygen
# follow prompts
ls -a ~/.ssh
cat ~/.ssh/id_rsa.pu
# add public key file to bitbucket account 
```

# Add Permissions
Shared files

# Add AWS load balancer https header
http://www.davidmataro.com/magento-https-and-amazon-aws-load-balancer

```
set $ssl "off";

if ($http_x_forwarded_proto = "https") {
    set $ssl "on";
}
```

```
location {
    fastcgi_param HTTPS $ssl;
}
```

# Change php.ini

max_execution_time