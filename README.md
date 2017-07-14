# docker-serverspec
`docker-serverspec` is a minimal Ruby image capable of running rspec / serverspec for the (integration) testing of Docker images.

## Getting Started

The following command can be used as an example as well as to test the `Dockerfile` for this repository.

```bash
$ docker run --rm --name integration-test \
➭ -v /var/run/docker.sock:/var/run/docker.sock \
➭ -v $(pwd):/docker-serverspec \
➭ -w /docker-serverspec \
➭ jadametz/serverspec \
➭ spec/
.

Finished in 1.88 seconds (files took 0.42518 seconds to load)
1 example, 0 failures
```
