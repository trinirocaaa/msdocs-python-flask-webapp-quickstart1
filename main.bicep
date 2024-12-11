@description('Deploy Azure resources using Bicep modules')
param location string = 'eastus'

@description('Name of the Azure Container Registry')
param containerRegistryName string

@description('Name of the Azure Service Plan')
param servicePlanName string

@description('Name of the Azure Web App')
param webAppName string

@description('Name of the container image in the registry')
param containerRegistryImageName string

@description('Version of the container image')
param containerRegistryImageVersion string

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
    serverFarmResourceId: resourceId('Microsoft.Web/serverfarms', servicePlanName)
    containerRegistryName: containerRegistryName
    containerRegistryImageName: containerRegistryImageName
    containerRegistryImageVersion: containerRegistryImageVersion
    dockerRegistryServerPassword: 'PLACEHOLDER_PASSWORD'
  }
}
