# What the hell is that ??
Vpipes is a project I initiated when I wanted to learn how-and-what-can I do with PMACCT. Starting lab-pmacct I needed a netflow data source to use it. So I started an unpublished project named lab-vqfx, based on the Junpier Virtual QFX (Junos 15.1) that @dgarros provided me.
Then I told myself :
  * Doing vqfx is not enough
  * you need something that can scale out to multiple nodes
  * I need a tool to get from a sketch to a running lab in minutes to test designs

# Install
  * Boot a new VM of your favorite distro
  * Savagely copy / paste the following commands (after checking of course)
```
apt-get update
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get install -y \
  git \
  jq \
  telnet \
  linux-image-extra-$(uname -r) \
  linux-image-extra-virtual \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common \
  docker-ce
apt-get remove docker docker-engine
apt-get update
service docker status
service docker start
```
  * Check that `/dev/kvm` exists because we are going to boot some VMs
  * Clone the repo : `# git clone https://github.com/fdebonneval/vpipes.git`
  * Build the vpipes-base image `# cd vpipes-base-image && make build`
  * Build the guest images you will need for your lab in the contrib folder
  * Transcribe your sketch into the lab.json file
  * Create the docker vpipes network
  * Use `# make consul` to launch Consul
  * Use `# make plan` to feed the terraform file
  * Or use `# make apply` to launch your lab

