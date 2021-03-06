#!/bin/bash

set -eux

auth_url=$(bosh interpolate ${root_dir}/vars.yml --path /auth_url)
openstack_domain=$(bosh interpolate ${root_dir}/vars.yml --path /openstack_domain)
openstack_project=$(bosh interpolate ${root_dir}/vars.yml --path /openstack_project)
openstack_username=$(bosh interpolate ${root_dir}/vars.yml --path /openstack_username)
openstack_password=$(bosh interpolate ${root_dir}/vars.yml --path /openstack_password)

# PCF automation interpolated
credhub set -n "/pcf/${name}/auth_url" \
  -t value -v "$auth_url"
credhub set -n "/pcf/${name}/openstack_domain" \
  -t value -v "$openstack_domain"
credhub set -n "/pcf/${name}/openstack_project" \
  -t value -v "$openstack_project"
credhub set -n "/pcf/${name}/openstack_username" \
  -t value -v "$openstack_username"
credhub set -n "/pcf/${name}/openstack_password" \
  -t password -w "$openstack_password"

credhub set -n "/pcf/${name}/openstack_ssh_private_key" \
  -t ssh -p "${keys_path}/pcf.pem"

credhub set -n "/pcf/${name}/opsman_instance_name" \
  -t password -w "pcf-opsman-${name}"
