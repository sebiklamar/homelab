Talos configuration is built upon `talhelper` and `kustomize` in order to follow DRY (don't repeat yourself).

- `talhelper` is used to generate talos configs (easier then talosctl)
- `kustomize` allows overlaying several yaml files for base, prod, dev configuration

Short documentation on how to use environment-specific talhelper using kustomize

```sh
cd envs/poc
mkdir clusterconfig
kustomize build -o clusterconfig
talhelper genconfig --config-file clusterconfig/generic-yaml_talconfig.yaml
talosctl config merge clusterconfig/talosconfig
for i in 103 105 106; do qm rollback $i initial; qm start $i; done
for i in $(cat hosts.txt) ; do talosctl apply-config --nodes $i --file clusterconfig/poc-talos1-$i.yaml --insecure; done
talosctl bootstrap -n 10.7.4.81
talosctl kubeconfig --talosconfig=clusterconfig/talosconfig --nodes=$(head -1 hosts.txt)
cp ~/.kube/config ~/.kube/config.bak && KUBECONFIG=~/.kube/config:output/kube-config.yaml kubectl config view --flatten > /tmp/config && mv /tmp/config ~/.kube/config
```