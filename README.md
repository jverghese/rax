rax
===

rax: A command line tool that gives you access to Rackspace services.

Services include : Cloud servers, monitoring, load balancers, dns, mailgun etc

Note: rax is currently not usable and still in development.

## Goals

* Single dependency: curl (no need to install golang, nodejs, pipi etc)
* Easy and intuitive ways to run commands for Rackspace services.
* Easily spawn up a session on control panel, dashboard when required.

## Installation:

```shell
curl https://raw.github.com/jverghese/rax/master/rax > rax
chmod +x rax
```

Setup your Rackspace credentials into ``~/.raxcreds`` with:  
Rackspace username
apikey

Note: The credentials are delimited by a new line.

## Usage
