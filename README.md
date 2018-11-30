# fast.ai development environment

A dev environment for fast.ai, providing scripts for provisioning, starting,
stopping, and tearing down AWS resources while working through the course.

## Setup

### Configuring Terraform remote state

- Create an S3 bucket for your Terraform remote state, following the pattern
  "<your-name>-fastai-environment-config-us-east-1"
- Create a subdirectory called `terraform` in your S3 bucket
- `cd deployment/terraform && cp terraform.tfvars.example terraform.tfvars`
- Edit `terraform.tfvars` to add your name and an SSH public key block for
  shelling into the instance
- Upload your `terraform.tfvars` file to
  `s3://<your-name>-fastai-environment-config-us-east-1/terraform/` 

### Editing environmental variables

- Adjust the `terraform` service in `docker-compose.ci.yml`:
    - Set the default value for `AWS_PROFILE` to the name of your R&D profile
    - Set the default value for `FASTAI_SETTINGS_BUCKET` to the name of your
      Terraform remote state bucket
- Adjust the value for `aws_profile` in `deployment/ansible/group_vars/all`
  to match the name of your R&D profile

### Provision resources

- Run `./scripts/setup` to provision your VM
    - Once your VM is set up, `./scripts/setup` will automatically call
      `./scripts/update` which will create AWS resources for you

## Developing

- Run `./scripts/server` in the VM to start your EC2 instance and run a server. Killing
  the server with `Ctrl+C` will automatically stop your EC2 instance.

- Run `./scripts/console` in the VM to shell into your EC2 instance. **Make sure your
  instance is running first.**

## Cleaning up

Delete Terraform resources:

```
vagrant@vagrant:/vagrant$ docker-compose \
                            -f docker-compose.ci.yml \
                            run --rm \
                                --entrypoint terraform \
                                --workdir "/usr/local/src/deployment/terraform" \
                                terraform destroy
```
