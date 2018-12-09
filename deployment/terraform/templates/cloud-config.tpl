#cloud-config

runcmd:
  - /home/ubuntu/src/anaconda3/envs/fastai/bin/pip install -U notebook
  - cd /home/ubuntu/fastai && git pull && git checkout v0.7.2 && /home/ubuntu/src/anaconda3/envs/fastai/bin/conda env update
