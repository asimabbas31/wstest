# Handbook for API Services Deployment
For API services we are using AWS infrastructure. The infastructure is based on AWS EC-2 Instances, AutoScaling Group, Application LoadBalancer, AMI and SSL Certificate. 

For Deployment Please follow the steps. 
## Pre-requestes 
Deployment of the payment services can only intiate through the bastion host. Not available outside AWS. 
## Steps 
As we have are using the multifactor authentication for aws login. Please enable multifactor authentication before starting the process. 

### SSH Access
```ssh ubuntu@bastion-api.safeboda.com```

#Call the function on bastion host to prepare the environment 
 
```bash 
source ~/deployment/prepare.sh
AWS Access Key ID: <Enter your Access Key>
AWS Secret Access Key <Enter Secret Key>
Default region name: eu-west-1
Default output format: json
Enter Multifactor Key
```  

  ### For deployment  
 ```bash
 cd deployment
 ansible-playbook -v deployment.yml

Select the environment.
1 - stage
2 - prod

enter the branchname and press enter default value: [master]: 
 
 ```
```
  ``` 
(Note after every restart all the parameter will reload again from aws parameter store). 


### Get all secrets for an environement

```bash
credstash -r eu-west-1 -t api_credential_store_{env} getall -f dotenv

```


### Add a secret to an environment

```bash
credstash -r eu-west-1 -t api_credential_store_{env} put -k alias/api_credstash_{env} {NAME_OF_KEY} {VALUE}

example:
credstash -r eu-west-1 -t api_credstash_store_stage ^Ct -k  alias/api_credstash_stage -v 2 ACTIVATION_SMS_MESSAGE "<#> Your SafeBoda verification code is: "
```
