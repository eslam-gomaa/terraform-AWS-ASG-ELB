# Creating a Load Balancing between a cluster of web servers on AWS with Terraform


## Update 📢
```
📺 Code has been updated to the latest syntax (July 3, 2020)
```

---


This is a Sample code to create a bunch of `webservers` behind a Load Balancer (`ELB`) with an Auto scaling group (`ASG`)



### Deploy a Cluster of Web Servers

We will use `ASG` to launch a `cluster` of `EC2` Instances,  monitoring the health of each Instance, replacing failed Instances, and adjusting the size of the cluster in response to load.

* `ASG` distributes the `EC2` instances across multiple `availability zones` 



### Deploy a Load Balancer

After deploying the `ASG` you'll have several different servers, each with its own IP address, but you need to give your end users only a single IP to hit, and for this we're going to deploy a load balancer to distribute traffic across your servers and to give your end users a single DNS name which is the the load balancer DNS name



---



# Install Terraform On Linux

For other platforms to install Terraform download the binary from the download page

https://www.terraform.io/downloads.html

```bash
yum -y install unzip

cd /tmp
wget https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip
unzip terraform_0.12.28_linux_amd64.zip -d /usr/bin/

terraform -v
```



---



# Usage

Insert your AWS `access key` & `secret key` as Environment Variables, In this way we're NOT setting them permanently, you'll need to run these commands again whenever you reopen your terminal

```bash
export AWS_ACCESS_KEY_ID=<your access key>
export AWS_SECRET_ACCESS_KEY=<your secret key>
```


```bash
yum -y install git
```



```bash
git clone https://github.com/Eslam-Naser/terraform-AWS-ASG-ELB.git
cd terraform-AWS-ASG-ELB/

# Downloading the Plugin for the AWS provider
terraform init
```



* See what's Terraform is planning to do before really doing it

```bash
terraform plan
```



* build the Terraform project

```bash
terraform apply
# yes | if you want to proceed
```

* destroy what you've built

```bash
terraform destroy
# yes | if you want to proceed
```



