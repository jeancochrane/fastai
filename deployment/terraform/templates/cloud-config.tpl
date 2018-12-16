#cloud-config

write_files:
    - content: |
        #!/bin/bash
        #
        # user_metric.sh -- sends user data to AWS CloudWatch
        #
        ACTIVE_USERS=$(uptime | awk '{ print $6 }')
        aws cloudwatch put-metric-data \
            --metric-name ActiveUsers \
            --dimensions Instance=${instance_id} \
            --namespace "Custom" \
            --value $ACTIVE_USERS
      path: /home/ec2-user/user_metric.sh
      permissions: '0755'
    - content: |
        #
        # cron.d/user_metric -- sends user data to AWS CloudWatch
        # /
        */1 * * * * /home/ec2-user/user_metric.sh
      path: /etc/cron.d/user_metric
      permissions: '0755'

runcmd:
  - /home/ubuntu/src/anaconda3/envs/fastai/bin/pip install -U notebook
  - cd /home/ubuntu/fastai && git pull && git checkout v0.7.2 && /home/ubuntu/src/anaconda3/envs/fastai/bin/conda env update
