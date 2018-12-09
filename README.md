# fast.ai development environment

A dev environment for fast.ai, providing scripts for provisioning, starting,
stopping, and tearing down AWS resources while working through the course.

## Quick examples 

Provision a GPU-enabled EC2 instance with all course materials installed:

```
$ ./scripts/setup
```

Start your instance and run a Jupyter Notebook server (the instance willstop
automatically when you kill the server):

```
$ ./scripts/server
```

Shell into your instance:

```
$ ./scripts/console
```

Destroy all AWS resources you've created:

```
$ docker-compose run --rm terraform ./scripts/infra destroy
```

## Setup

### Requirements

- Vagrant 2.0.0+
- VirtualBox 5.1+

### Creating Terraform variables

Start by copying the example variable file:

```
$ cd deployment/terraform && cp terraform.tfvars.example terraform.tfvars
```

Next, edit `terraform.tfvars` to add your name, the office IP address, and an SSH public
  key block for shelling into the instance.

Finally, make sure that the key you're using to shell into your instance is added to
  your SSH agent so that Vagrant can forward it to your VM:

```
$ ssh-add path/to/key.pem
```

### Editing environmental variables

First, adjust the `terraform` service in `docker-compose.yml` to set the default
  value for `AWS_PROFILE` to the name of your R&D profile.

Then, adjust the value for `aws_profile` in `deployment/ansible/group_vars/all`
  to match the name of your R&D profile.

### Provision resources

Run `./scripts/setup` to provision your VM. `setup` will automatically call
`./scripts/update`, which will create and update all AWS resources for you.

After the server is provisioned, it will need a few minutes to finish running
setup scripts before it becomes ready to serve files. Plan to take a few minutes
for a break before you start the next steps.

## Developing

To start developing, SSH into your VM with `vagrant ssh -- -A` in order to enable
  SSH forwarding. This is necessary in order to access your instance
  from inside the VM.

To **start your instance and run a Jupyter notebook**, run the `server` script in the VM
  and visit the URL pasted in the output:

```
vagrant@vagrant:/vagrant$ ./scripts/server
```

Killing the server with `Ctrl+C` will automatically stop your EC2 instance.

To shell into your instance, run the `console` script inside the VM:

```
vagrant@vagrant:/vagrant$ ./scripts/server
```

Note that `console` **assumes your instance is already running.** In order to
prevent the two scripts from clobbering one another, the scripts assume that
`server` is controlling your instance start/stop cycle, and `console` is simply
attempting to access that server.

### Troubleshooting

#### `IncorrectInstanceState`

Sometimes if you try to start the server too quickly after stopping it,
`./scripts/server` will raise this error:

```
An error occurred (IncorrectInstanceState) when calling the StartInstances operation: The instance '<instance-id>' is not in a state from which it can be started.
```

This is normal, and simply indicates that the previous `StopInstances` operation
hasn't completed and the instance is still in a pending state. Wait a minute or
two and try again.

#### `./scripts/console` hangs

There are a few reasons that SSH might hang when you attempt to login to your
instance:

- You're not on the network whitelisted in the instance CIDR block
    - Solution: Login to the VPN
- You haven't added the SSH key for your instance to your SSH agent
    - Solution: Run `ssh-add /path/to/key.pem`
- You didn't forward the SSH agent to Vagrant
    - Solution: Exit the VM and run `vagrant ssh -- -A`

#### `./scripts/server` exits with `ssh: Could not resolve hostname : Name or service not known`

This can happen if the AWS CLI `StartInstances` command returns before the
public hostname of the instance is resolvable. In this case, wait a few seconds
and try running
`./scripts/server` again and you should see the correct output.

## Cleaning up

If you'd like to delete AWS resources, use the `infra` script:

```
vagrant@vagrant:/vagrant$ docker-compose run --rm terraform ./scripts/infra destroy
```

This will remove all AWS resources that you created using the `setup` script. 
