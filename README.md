# raxio_prereqs
Prerequisites for Raxio 2015

### These are the pre-requisites needed for ci/cd workshop at Rax.io 2015

- Jenkins 
- Sonar
- Autocreator
- Ansible
- Jenkins plugins and jobs (sonar and github pr.  Need to also validate pyenv gets installed)
  - Build Flow
    - Upstream\_master\_pulldown
    - Build\_flow
    - Unit\_tests
    - Functional\_tests
    - Performance\_tests
    - Deployer
  - Release deployer
    - Artifact\_builder
    - Staging\_deployer
    - Production\_deployer
  - Upstream patch
    - Upstream\_patch\_trigger
    - Upstream\_build\_flow
    - Unit\_tests
    - Functional\_tests
    - Performance\_tests
  - Downstream patch
    - Downstream\_patch\_trigger
    - Unit\_tests
    - Functional\_tests
    - Performance\_tests
- Git
- Ruby (STILL TO DO)
- Python
- Java
- Scripts (STILL TO DO)
- Ansible deployment job

### Manual steps

- Set up src/raxpub with cloud credentials
- Add access token to Github PR Builder (required as pre-req to workflow 3)
