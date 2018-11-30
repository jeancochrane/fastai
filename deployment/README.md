# Deployment

* [AWS Credentials](#aws-credentials)
* [Terraform](#terraform)

## AWS Credentials

Using the AWS CLI, create an AWS profile named `fastai`:

```bash
$ vagrant ssh
vagrant@vagrant-ubuntu-trusty-64:~$ aws --profile fastai configure
AWS Access Key ID [****************F2DQ]:
AWS Secret Access Key [****************TLJ/]:
Default region name [us-east-1]: us-east-1
Default output format [None]:
```

You will be prompted to enter your AWS credentials, along with a default region. These credentials will be used to authenticate calls to the AWS API when using Terraform and the AWS CLI.

## Terraform

To deploy this project's core infrastructure, use the `infra` wrapper script to lookup the remote state of the infrastructure and assemble a plan for work to be done:

```bash
vagrant@vagrant-ubuntu-trusty-64:~$ export FASTAI_SETTINGS_BUCKET="jcochrane-fastai-environment-config-us-east-1"
vagrant@vagrant-ubuntu-trusty-64:~$ export AWS_PROFILE="fastai"
vagrant@vagrant-ubuntu-trusty-64:~$ docker-compose -f docker-compose.ci.yml run --rm terraform ./scripts/infra plan
```

Once the plan has been assembled, and you agree with the changes, apply it:

```bash
vagrant@vagrant-ubuntu-trusty-64:~$ docker-compose -f docker-compose.ci.yml run --rm terraform ./scripts/infra apply
```

This will attempt to apply the plan assembled in the previous step using Amazon's APIs. In order to change specific attributes of the infrastructure, inspect the contents of the environment's configuration file in Amazon S3.
