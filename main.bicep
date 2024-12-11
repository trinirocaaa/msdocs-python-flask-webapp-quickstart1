@description('Deploy Azure resources using Bicep modules')
param location string = 'eastus'

var containerRegistryName = 'myContainerRegistry'
var servicePlanName = 'myServicePlan'
var webAppName = 'myWebApp'

module containerRegistry './container-registry.bicep' = {
  name: 'DeployContainerRegistry'
  params: {
    name: containerRegistryName
    location: location
    acrAdminUserEnabled: true
  }
}

module servicePlan './service-plan.bicep' = {
  name: 'DeployServicePlan'
  params: {
    name: servicePlanName
    location: location
  }
}

module webApp './web-app.bicep' = {
  name: 'DeployWebApp'
  params: {
    name: webAppName
    location: location
    serverFarmResourceId: servicePlan.outputs.serverFarmResourceId
    containerRegistryName: containerRegistryName
    containerRegistryImageName: 'myimage'
    containerRegistryImageVersion: 'latest'
  }
}
