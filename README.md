# aws-asg-rabbitmq-docker-cluster
AWS Auto Scaling Group RabbitMQ Docker Cluster

This Terraform script will create an AWS auto scaling group with linux servers running docker RabbitMq containers to form a cluster.

For proper DNS resolution, depending upon your environment, you must customize the following code in the cloud-init.yaml file. 

Change the IP addresses ('192.168.201.6', '192.168.202.7') to point to your DNS servers and change "mydomain.com" to your domain name. Leave the IP address, '169.254.169.253', since this is the internal AWS DNS IP address. 

Adjust the domain ec2.internal if you are not using us-east-1 as your deployment region and substitue <<region_name>>.compute.internal 

    manage_resolv_conf: true
    resolv_conf:
    nameservers: ['169.254.169.253', '192.168.201.6', '192.168.202.7']
    searchdomains:
        - ec2.internal
        - amazonaws.com
        - mydomain.com
    domain: ec2.internal 
    # Must be changed to <<region_name>>.compute.internal for non us-east-1 regions.


Output will provide the admin, rabbit user passwords along with the URL for the load balancer.
