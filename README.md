# binhex386_platform

binhex386 Platform repository

# CHANGELOG

## 2022-04-05 Homework-2

1. Kind cluster with 3 master nodes and 3 worker nodes was deployed locally.
2. Frontend microservice was deployed via ReplicaSet.
3. The manifest was invalid due to missing `selector` section (as well as previously fixed missing `env` section).
4. Frontend microservice was upscaled to 3 replicas via ad-hoc command.
5. It was verified that pods are being restored after manual deletion.
6. It was verified that re-applying the manifest restores number of replicas. The number of replicas in the manifest was set to 3.
7. It was verified that after changing container image name in the manifest and re-applying does not upgrade the container. **This is because ReplicaSet does not check that running pods match the template.** However, manually deleting running pods would result in applying a new template.
8. PaymentService was deployed in the same way as Frontend microservice. The image of the service was tagged with `v0.0.1` and `v0.0.2` and pushed to Docker Hub.
9. Deployment manifest to PaymentService was created and deployed.
10. It was verified that changing container image version number and re-applying the manifest results in deployment update.
11. It was verified that `kubectl rollout undo deployment` allows to revert previous changes.
12. ⭐ "Blue-Green" and "Reverse Rolling" update strategies were implemented with `maxSurge` and `maxUnavailable` parameters.
13. Readiness probe was addede to a Frontend deployment manifest. It was verified that update stops on first pod if probe URL path is invalid.
14. Status of the deployment was checked with `kubectl rollout status` command.
15. ⭐ Node exported daemon set manifest was applied. It was verified that with port forwarding metrics are available via localhost.
16. ⭐⭐ Well, in fact, the first manifest I've found was already able to run exported on master nodes. However, I guess that the key to the task is the `nodeSelector` parameter.

## 2022-03-30 Homework-1

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
