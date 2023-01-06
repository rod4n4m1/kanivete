# SRE@Kyndryl

## SRE Public Tools - Kanivete

* Version: `0.1.1`
* License: `MIT`
* Description: `A swiss army knife container image to aid debugging Kubernetes issues`
* Reference: [K8s doc](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/)

## Contents

* Folder: **build**

## Usage

### Deploy a Target App

* You can deploy a standard nginx deployment for testing
`kubectl apply -f usage/nginx-deployment.yaml`

### Ephemeral Debug Container (K8s v1.25)

* Debug a running container by attaching **kanivete** to it as an ephemeral container:
`kubectl debug -it nginx-deployment-6ddcfb665f-hcj4c --image=rod4n4m1/kanivete:0.1.1 --target=nginx`

* Re-attach the ephemeral container if needed (to be implemented):
`kubectl attach nginx-deployment-6ddcfb665f-hcj4c -c debugger-rpk9w -i -t`

### Independent Pod

* Create a new pod based on the latest **kanivete** image:
`kubectl run kanivete --image=rod4n4m1/kanivete:0.1.1 -- sleep 1d`

* Open sh terminal on the **kanivete** container:
`kubectl exec -it kanivete -- sh`
