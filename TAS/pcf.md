# Setup Delegate

- Install cf v7 cli in the delegate
- curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=v7&source=github" | tar -zx
mv cf7 /usr/local/bin/cf
- This is already automated using terraform and is for informational purpose only.

# Setup Connectors

## Artifactory Connector

- Harness Artifactory connection needs to be automated 
- Customer doesnt need to do this
- myharnessartifactory
- https://harness.jfrog.io/artifactory
- annonymous credentials

## Part 1 Create Tanzu Application Service Connector


- Click `New Connector`
- Search `Tanzu`
- Click `Tanzu Application Service`
  
![screenshot-tbd.png]

---
- Name:
```
mytasconnector
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
- Select Secret: `mytassecret`
- Click `Continue`
- Connect to the provider: `Connect through a Harness Delegate`
- Click Save and Continue



- Click Finish
- `TAS connector` has been successfully configured

![screenshot-tbd.png]

## Part 2 Create Tanzu Application Service Infra definition
- Click `Environments`
- Click `mydevenv`
- Click `Infrastructure Definitions`
- Click `+ Infrastructure Definition`
- Name:
```
mytasdevinfra
```
- Click `Tanzu Application Service`
- Click `Connector`
- Select `mytasconnector`
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
mytasservice
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
mytasmanifest
```
- Repository Name
```
my-tas-service.git
```
- Branch
```
main
```
- File/Folder Path
```
deployment/dev/manifest.yaml
```
- Click `+ Add File` to add Vars.yaml
- Vars.yaml
```
deployment/dev/vars.yaml
```
- Click `Submit`
- Click `Save`
  
---

- Click `Add Artifact Source`
- Artifact Repository Type: `Artifactory`
- Click `Continue`
- Artifactory Connector
```
myharnessartifactory
```
- Click `Apply Selected`
- Click `Continue`
- Artifact Source Identifier:
```
mysampleartifact
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
mytasbgpipeline
```
- Click `Start`
- Add a new stage of type `Deploy`
- Stage Name:
```
mydevdeployment
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
mytasservice
```
- Artifact Path
```
demo/sample-app/1.0.0/sample-app-1.0.0.zip
```
- Specify Environment
```
mydevenv
```
- Click `Apply Selected`
- Specify Infrastructure
```
mytasdevinfra
```
- Run Pipeline



Part 6 - Conclusion
===

- You have successfully completed configured a TAS application and infra definition and deployed using blue green strategy.
- We will leverage these connectors to build our pipelines in the journey ahead

![screenshot-tbd.png]

---
> 📍 **NOTE**  \
> Explore the questions below:
---

- When should we select: connect through Harness Platform vs connect through Harness Delegate?
- What should be the scope of the connectors - Account, Organization or Project?
- How would you map TAS Organization to corresponding Harness Entities - Organization or Project?
- What is the desired topology for Environment and Infra Definition?
