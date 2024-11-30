# ToDo

- [ ] document folder structure
- [ ] document kustomize overlay approach (incl. transformers and components)

# Manual bootstrap

> [!Substitute `<env>` with the specific environment, e.g. dev, qa, prod]
> 

## Gateway API

```shell
kustomize build --enable-helm k8s/core/network/gateway/envs/<env> | kubectl apply -f -
```

## Cilium

```shell
kustomize build --enable-helm k8s/core/network/cilium/envs/dev | kubectl apply -f -

kubectl -n kube-system get configmap cilium-config -o yaml
```

# Application

## Example: whoami

```shell
kustomize build --enable-helm k8s/apps/diag/whoami/envs/<env> | kubectl apply -f -
```

## Copy-paste
```shell
```