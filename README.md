# fargate CLI demo

## Pre-Requisite

1. Clone this repo to your machine. 
2. Install the AWS CLI v1.
3. Have your own AWS account and login credentials setup.
4. Download and install the fargate cli:

https://github.com/awslabs/fargatecli/releases

Also recommended - Watch the demo movie on this page:
https://www.youtube.com/watch?v=P6iY6ovhbfc


## Other pre-requistite steps

5. Own your own domain or hosted zone on Route53.

In the example commands below my domain is **andy.work** - you will need to change this to your own top level domain/zone.

6. One time setup - create an AWS certificate in ACM using the fargate cli:

### :star: Tips
:bulb: Be sure to work out of a region that fargate is supported from (eg. eu-west-1)
Always specify the **--region** option when using the fargate cli 

```console
$ fargate certificate request fgdemo1.andyt.work --region eu-west-1
```
```
 ℹ️  Requested certificate for fgdemo1.andyt.work

You must validate ownership of the domain name for the certificate to be issued.

If your domain is hosted using Amazon Route 53, this can be done automatically by running:
    fargate certificate validate fgdemo1.andyt.work

If not, you must manually create the DNS records returned by running:
    fargate certificate info fgdemo1.andyt.work

```


```console
$ fargate certificate validate fgdemo1.andyt.work --region eu-west-1
```

Wait about 2-3 minutes and check the status of your new certificate

```console
$ fargate certificate info fgdemo1.andyt.work --region eu-west-1
```




With this all done your ready for the main demo:


## Main fargate cli Demo

Get the fargate cli to create a load balancer for your service using your certificate:

```console
fargate lb create fgdemo1 --port 443 --certificate fgdemo1.andyt.work --region eu-west-1
```

This next command does a few things - performs a local docker build, creates a new ECR registry, tasg and pushed the local docker image into the registry, 

```console
$ fargate service create fgdemo1 --port HTTP:80 --lb fgdemo1 --num 3 --region eu-west-1
```

Get some info about the new serbvice
```console
$ fargate lb info fgdemo1 --region eu-west-1
```

Wait until it says status "Running"

Note the dns name of the loadbalancer:

```
$ fargate  service info myapp --region eu-west-1 | grep DNS
```

Wait another 60 seconds for the load balancer health checks to clear

Now you can hit the URL:

https://your.load.balancer.url

You'll need to accept the security exception for the certificate.

To fix that longer term do:

```console
fargate lb alias myapp fgdemo1.andyt.work --region eu-west-1
```

After the DNS records propegate you cn hit https://fgdemo1.andyt.work  without any security alerts in the browser as the cert will match the service name.


