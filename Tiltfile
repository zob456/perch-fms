# -*- mode: Python -*-

# PostgreSQL
docker_build(
    'perchfms-db',
    '.',
    dockerfile='etc/workstation/db/Dockerfile'
)

# API
docker_build(
    'perchfms-api',
    '.',
    dockerfile='cmd/deployments/Dockerfile'
)

k8s_yaml([
    './etc/workstation/db/deployment.yaml',
    './cmd/deployments/kubernetes.yaml',
])

k8s_resource(workload='postgres', port_forwards=5400)
k8s_resource(workload='perchfms-api', resource_deps=['postgres'], port_forwards=8000)