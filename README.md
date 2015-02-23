# raxio_prereqs
Prerequisites for Raxio 2015

### These are the pre-requisites needed for ci/cd workshop at Rax.io 2015

- Jenkins 
- Sonar
- Autocreator
- Ansible
- Gerrit (http://raxio2015-gerrit.dimitryushakov.com:8080) - need to create a proxy for ssh tunneling - make sure others have bastions.  Add .ssh/config setting to make sure
- Jenkins plugins and jobs (update all projects with real projects)
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
- Python
- Java
- Scripts (TODO)
- Ansible deployment job

### Manual steps

- Set up src/raxpub with cloud credentials
- Add access token to Github PR Builder (required as pre-req to workflow 3)
- Add rax-demo-[your name] user to upstream jobs
