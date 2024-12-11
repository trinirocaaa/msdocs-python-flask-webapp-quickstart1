@description('Location for resources')
param location string

@description('Container Registry Name')
param containerRegistryName string

@description('Container Registry Image Name')
param containerRegistryImageName string

@description('Container Registry Image Version')
param containerRegistryImageVersion string

@description('Service Plan Name')
param servicePlanName string

@description('Web App Name')
param webAppName string

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
    containerRegistryImageName: containerRegistryImageName
    containerRegistryImageVersion: containerRegistryImageVersion
  }
}