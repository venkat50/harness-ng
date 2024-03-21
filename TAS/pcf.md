# Setup Delegate

- Install cf v7 cli in the delegate
- curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=v7&source=github" | tar -zx
mv cf7 /usr/local/bin/cf
- This is already automated using terraform and is for informational purpose only.

# Setup Connectors

## Artifactory Connector

- Harness Artifactory connection needs to be automated 
- Customer doesnt need to do this
- https://harness.jfrog.io/
- annonymous credentials

## Part 1 Create Tanzu Application Service Connector


- Click `New Connector`
- Search `Tanzu`
- Click `Tanzu Application Service`
  
![screenshot-tbd.png]

---
- Name:
```
my_tas_connector
```
- Click `Continue`
![screenshot-tbd.png]

---

- Endpoint URL:
```
 https://api.system.tas-qa-setup.com
```
- Username:
```
labuser
```
- Password: Click `Create or Select a Secret`
- Select Secret: `my_tas_password`
- Click `Continue`
- Connect to the provider: `Connect through a Harness Delegate`
- Click Save and Continue



- Click Finish
- `TAS connector` has been successfully configured

![screenshot_2024-02-29_23.36.03.png](../assets/screenshot_2024-02-29_23.36.03.png)

## Part 2 Create Tanzu Application Service Infra definition
- Click `Environments`
- Click `dev`
- Click `Infrastructure Definitions`
- Click `+ Infrastructure Definition`
- Name:
```
my_tas_dev
```
- Click `Tanzu Application Service`
- Click `Connector`
- Select `my_tas_connector`
- Click `Apply Selected`
- Click `Organization`
- Select `venkat-org`
- Click `Space`
- Select `dev`
- Click `Save`

## Part 3 Create Harness Service
- Click `Service`
- Click `New Service`
- Name:
```
my_tas_service
```
- Click `Save`
- Click `Tanzu Application Services`
- Click `+ Add Manifest`
- Click `TAS Manifest`
- Click `Continue`
- Select `GitHub`
- Select `GitHub Connector`
- Click `Continue`
- Manifest Identifier:
```
my_tas_manifest
```
- Repository Name
```
harness-ng
```
- Branch
```
main
```
- File/Folder Path
```
TAS/DEV
```
- Click `+ Add File` to add Vars.yaml
- Vars.yaml
```
TAS/DEV/vars.yaml
```
- Click `Submit`
- Click `Save`
  
---

- Click `Add Artifact Source`
- Artifact Repository Type: `Artifactory`
- Click `Continue`
- Artifactory Connector
```
harness-artifactory
```
- Click `Apply Selected`
- Click `Continue`
- Artifact Source Identifier:
```
my_sample_artifact
```
- Repository Format
```
Generic
```
- Repository
```
cf-tutorial
```
- Artifact Filter
```
demo/sample-app/*/*.zip
```
- Artifact Path
```
<+input>
```
- Click `Submit` 

- Click `Save`

## Part 3 Create Harness Pipeline

# Create Pipeline
- Click `Create Pipeline`
- Name:
```
my_tas_bg_pipeline
```
- Click `Start`
- Add a new stage of type `Deploy`
- Stage Name:
```
my_dev_deployment
```
- Deployment Type: `Tanzu Application Services`
- Click `Set Up Stage`
- Select Service: `Runtime input`
- Specify Environment: `Runtime input`
- Select `Blue Green`
- Click `Use Strategy`
- Execution Tab will show the `BG App Setup` Step
- Click `Save`
- Click `Run`

--- 
Part 5 - Execute Pipeline and review
- Click on run pipeline and review
- Review logs and input output variables for each stage

- Select service 
```
my_tas_service
```
- Specify Environment
```
dev
```
- Click `Apply Selected`
- Specify Infrastructure
```
my_tas_dev
```
- 



Part 6 - Conclusion
===

- You have successfully completed creating different connectors in Harness to connect with a Code Repo, a Container Registry and a Kubernetes Cluster
- We will leverage these connectors to build our pipelines in the journey ahead

![screenshot_2024-03-01_10.22.09.png](../assets/screenshot_2024-03-01_10.22.09.png)

---
> 📍 **NOTE**  \
> Explore the questions below:
---

- When should we select: connect through Harness Platform vs connect through Harness Delegate?
- What should be the scope of the connectors - Account, Organization or Project?
- How would you map TAS Organization to corresponding Harness Entities - Organization or Project?
- What is the desired topology for Environment and Infra Definition?
