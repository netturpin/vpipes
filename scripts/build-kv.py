#!/usr/bin/python3

import json
import sys

providers =  """# Configure the Docker provider
provider "docker" {
    host = "unix:///var/run/docker.sock"
}

# Configure the Consul provider
provider "consul" {
    address = "127.0.0.1:8500"
    datacenter = "vpipes"
}
"""

kv_header = """resource "consul_keys" "cables" {"""

kv_footer = """}"""

kv_key_header = """    key {"""

kv_key_footer = """    }"""

containers = """
resource "docker_container" "ubuntu" {
  name = "foo"
  image = "${docker_image.ubuntu.latest}"
}
"""

# Opening first argument as json lab datasource
with open(str(sys.argv[1])) as data_file:    
    data = json.load(data_file)

# Making device list based on the lab file
devices = []
for each in data['devices']:
    devices.append(each['name'])

print (providers)
print (kv_header)
for device in devices:
    for cable in data['cables']:
        if cable['ahost'] == device:
           print (kv_key_header)
           print ("        path = \"cables/",device,"/",cable['abridge'],"\"", sep="")
           print ("        value = \"",cable['bhost'],"-",cable['tun-id'],"\"", sep="")
           print (kv_key_footer)
        if cable['bhost'] == device:
           print (kv_key_header)
           print ("        path = \"cables/",device,"/",cable['bbridge'],"\"", sep="")
           print ("        value = \"",cable['ahost'],"--",cable['tun-id'],"\"", sep="")
           print ("        delete = \"","true","\"", sep="")
           print (kv_key_footer)
print (kv_footer)

for each in data['devices']:
    print ("resource \"docker_container\" \"", each['name'] ,"\" {", sep="")
    print ("  name = \"",each['name'],"\"", sep="")
    print ("  hostname = \"",each['name'],"\"", sep="")
    print ("  image = \"",each['image'],"\"", sep="")
    print ("  networks = [\"vpipes\"]", sep="")
    print ("  privileged = true")
    print ("}")

    
