# Creating a Load Balancing between a cluster of web servers on AWS with Terraform

this repo is an example of using `ELB` **Elastic Load Balancing** with `ASG` **Auto Scaling Group** to provide highly available and efficient web servers



### Deploy a Cluster of Web Servers

we will use `ASG` to launch a `cluster` of `EC2` Instances,  monitoring the health of each Instance, replacing failed Instances, and adjusting the size of the cluster in response to load.

* `ASG` distributes the `EC2` instances across multiple `availability zones` 
  * each `AWS account` has access to different set of `Availability zones`, in this repo, i've choosed `all` availability zones available in my account

## Deploy a Load Balancer

after deploying the `ASG` you'll have serveral different servers, each with its own ip address, but you need to give your end users only a single IP to hit, and for this we're going to deploy a load balancer to distribute traffic accross your servers and to give your end users a single dns name which is the the load balancer dns name

---



# Install Terraform On Linux

For other platforms to install Terraform download the binray from the download page

https://www.terraform.io/downloads.html

```bash
yum -y install unzip

cd /tmp
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip terraform_0.11.7_linux_amd64.zip -d /usr/bin/

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



* See what's terraform is planning to do before really doing it

```bash
terraform plan
```



* build the terraform project

```bash
terraform apply
# yes | if you want to proceed
```

* destroy what you've built

```bash
terraform destroy
# yes | if you want to proceed
```

