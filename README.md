# docker-serverspec
`docker-serverspec` is a minimal Ruby image capable of running rspec / serverspec for the (integration) testing of Docker images.

## Getting Started

The following command can be used and tested in the `examples/` directory.

```bash
$ docker run --rm --name integration-test \
➭ -v /var/run/docker.sock:/var/run/docker.sock \
➭ -v $(pwd):/app \
➭ -w /app \
➭ jadametz/serverspec \
➭ Dockerfile_spec.rb
.

Finished in 1.88 seconds (files took 0.42518 seconds to load)
1 example, 0 failures
```
