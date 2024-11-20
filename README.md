# SRE@Kyndryl

## SRE Public Tools - Kanivete

* Version: `0.3.0`
* License: `MIT`
* Description: `A swiss-army-knife debug container image to aid troubleshooting Kubernetes issues`
* Base image: `Ubuntu Noble (latest)`
* Reference: [K8s doc](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/)

## Contents

* Folder: **build**

| **Filename** | **Description** | **Usage** |
|:-------------|:----------------------------|:----------------------------|
| building-example.txt | An example of the environmental variables required by the scripts located in this directory. Modify the values and rename it to `building.env`. | N/A |
| docker-build.sh | A `shell script` that builds and pushes the **kanivete** image using *docker* CLI, requires environmental variables defined on a file named `building.env`. | `$ ./docker-build.sh`|
| podman-build.sh | A `shell script` that builds and pushes the **kanivete** image using *podman* CLI, requires environmental variables defined on a file named `building.env` and the `podman-build` addon installed. | `$ ./podman-build.sh`|
| Dockerfile | A Docker-based script that holds the instructions to build a container image. | N/A |
| | | |

## Usage

### Kubernetes

#### Deploy a Target App

* You can deploy a standard nginx deployment for testing

`kubectl apply -f usage/nginx-deployment.yaml`

#### Ephemeral Debug Container (K8s v1.25+)

* Debug a running container by attaching **kanivete** to it as an ephemeral container:

`kubectl debug -it nginx-deployment-6ddcfb665f-hcj4c --image=rod4n4m1/kanivete:0.3.0 --target=nginx`

* Re-attach the ephemeral container if needed (to be implemented):

`kubectl attach nginx-deployment-6ddcfb665f-hcj4c -c debugger-rpk9w -i -t`

#### Independent Debugger Pod

* Create a new pod based on the latest **kanivete** image:

`kubectl run kanivete --image=rod4n4m1/kanivete:0.3.0 -- sleep 1d`

* Open terminal shell on the **kanivete** pod:

`kubectl exec -it kanivete -- bash`

### Container Runtime

#### Using with Docker or Podman

* Create a new container from the latest **kanivete** image:

`docker run -d --name kanivete rod4n4m1/kanivete:0.3.0 sleep 1d`
`podman run -d --name kanivete rod4n4m1/kanivete:0.3.0 sleep 1d`

* Open terminal shell on the **kanivete** container:

`docker exec -it kanivete bash`
`podman exec -it kanivete bash`

## End of Doc
