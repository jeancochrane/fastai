# fast.ai development environment

A dev environment for fast.ai, providing scripts for provisioning, starting,
stopping, and tearing down AWS resources while working through the course.

## Requirements

- Vagrant 2.0.0+
- VirtualBox 5.1+

## Setup

### Creating Terraform variables

- `cd deployment/terraform && cp terraform.tfvars.example terraform.tfvars`
- Edit `terraform.tfvars` to add your name, the office IP address, an SSH public
  key block for shelling into the instance

### Editing environmental variables

- Adjust the `terraform` service in `docker-compose.ci.yml`:
    - Set the default value for `AWS_PROFILE` to the name of your R&D profile
- Adjust the value for `aws_profile` in `deployment/ansible/group_vars/all`
  to match the name of your R&D profile

### Provision resources

- Run `./scripts/setup` to provision your VM
    - `./scripts/setup` will automatically call
      `./scripts/update` which will create AWS resources for you

## Developing

- SSH into your VM with `vagrant ssh -- -A` in order to enable SSH forwarding
  (for shelling into your instance)

- Run `./scripts/server` in the VM to start your EC2 instance and run a server. Killing
  the server with `Ctrl+C` will automatically stop your EC2 instance.

- Run `./scripts/console` in the VM to shell into your EC2 instance. **Make sure your
  instance is running first.**

## Cleaning up

Delete Terraform resources:

```
vagrant@vagrant:/vagrant$ docker-compose run --rm terraform ./scripts/infra destroy
```
