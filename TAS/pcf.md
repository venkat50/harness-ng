
> 🚀 **START**  \
> Instructions on TAS

--------



Part 1 - Artifactory Connector
===

- From the [button label="Harness UI" variant="success"](tab-1) tab, navigate to: `Project Settings > Project Level Resources > Connectors`
- Click `New Connector`
- Search `Artifactory`
- Click `Aritfactory`
---
- Name:
```
myharnessartifactory
```
- Artifactory Repository URL
```
https://harness.jfrog.io/artifactory
```
- Authentication: Annonymous (no credentials required)
- Click `Continue`
- Connect to the provider: `Connect through a Harness Delegate`
- Click Save and Continue
- Click Finish
- `Artifactory connector` has been successfully configured

Part 2 - Create TAS Connector
===

- From the [button label="Harness UI" variant="success"](tab-1) tab, navigate to: `Project Settings > Project Level Resources > Connectors`
- Click `New Connector`
- Search `Tanzu`
- Click `Tanzu Application Service`



---
- Name:
```
mytasconnector
```
- Click `Continue`


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

Part 3 - Create TAS Infra definition
===

- From the [button label="Harness UI" variant="success"](tab-1) tab, navigate to: `Project Settings > Project Level Resources > Environments`
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
- Select `my-org`
- Click `Space`
- Select `dev`
- Click `Save`

Part 4 - Create TAS Service
===
- From the [button label="Harness UI" variant="success"](tab-1) tab, navigate to: `Project Settings > Project Level Resources > Services`
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

Part 5 - Create TAS Blue Green Pipeline
===

- From the [button label="Harness UI" variant="success"](tab-1) tab, navigate to: `Pipelines`
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

Part 6 - Execute Pipeline and Review
===

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

- Click on run pipeline
- Review logs and input output variables for each stage

Part 7 - Conclusion
===

- You have successfully completed configured a TAS application and infra definition and deployed using blue green strategy.
- We will leverage these connectors to build our pipelines in the journey ahead

---
> 📍 **NOTE**  \
> Explore the questions below:
---

- When should we select: connect through Harness Platform vs connect through Harness Delegate?
- What should be the scope of the connectors - Account, Organization or Project?
- How would you map TAS Organization to corresponding Harness Entities - Organization or Project?
- What is the desired topology for Environment and Infra Definition?

---
> ✅ **CONGRATULATIONS !!!**  \
> Please type 'next' in the [button label="MyLocalServer" variant="success"](tab-7) tab to continue.
> ```bash,run
> next
> ```
