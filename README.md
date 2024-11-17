# UNDER CONSTRUCTION

That mono-repo is still in an evolving state with several PoCs (proof-of-concepts), i.e. _not_ containing any production k8s/homelab implementation, yet.

Nevertheless, you can find some interesting PoCs for

- docker-compose implementation for unifi network controller (the new version requires separation from the mongo db container)
- talhelper (for talos) feat. environment-specific definitions (DRY)
- tofu (terraform) code for IaC-ing proxmox VMs, needed for talos
- terragrunt for even more IaC, thus allowing the use of versioned terraform/tofu modules for several environments
- k8s apps definition leveraging `kustomize`'s patching and transformer capabilities for defining a base and (similar to the environment-specfic course done for talhelper)

It's all about IaC and DRY -- and my future homelab (based on [vehagn/homelab]) :-)