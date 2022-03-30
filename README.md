# binhex386_platform

binhex386 Platform repository

# CHANGELOG
## Homework #1

1. Why the pods were restarted after `docker rm -f` and `kubectl delete pod`? What is different about how the pods `core-dns` and `kube-apiserver` are restarted?
   - The pod `core-dns` was restored because it was previously deployed as a *Deployment* resource. So, the *scheduler* tracks that there are enough replicas of the corresponding service is *Running*.
   - The pod `kube-apiserver` was restores becaise it is defines in `/etc/kubernetes/manifests/kube-apiserver.yaml` as a *Pod* resource. So, the *kubelet* tracks that this pod is running.
2. The `Dockerfile` for the `web` service is created. The `USER` directive was not used because of how `nginx` wants to start as root and then drop its priviledges. So, nginx config file was patched instead.
3. The image was pushed to docker.io as `binhex386/kubernetes-intro`.
4. The `web-pod.yml` manifest was created and applied locally.
   - Status of the pod was verified with `get` and `describe`.
   - It was verified that the error occurs when the manifest is being applied with an invalid image name.
   - `initContainer` and ephemeral volume were defined to dynamically pull content when the pod is being created.
   - Pod was restarted and its status was verified again.
   - The service was manually checked with `port-forward`.
5. The manifest of the `frontend` service of `microservices-demo` was created:
  - The image `binhex386/frontend-demo` was built and pushed to docker.io.
  - The manifest was bootstrapped with `run --dry-run=client`.
  - All required environment variables were added to the manifest so that the service could start.
  - The resulting manifest was saved as `frontend-pod-healthy.yaml`.
