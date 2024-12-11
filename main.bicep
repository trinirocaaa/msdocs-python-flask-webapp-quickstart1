param containerRegistryName string
param containerRegistryLocation string
param servicePlanName string
param servicePlanLocation string
param webAppName string
param webAppLocation string
param containerRegistryImageName string
param containerRegistryImageVersion string

module containerRegistry 'modules/container-registry.bicep' = {
  name: 'containerRegistry'
  params: {
    name: containerRegistryName
    location: containerRegistryLocation
    acrAdminUserEnabled: true
  }
}

module servicePlan 'modules/service-plan.bicep' = {
  name: 'servicePlan'
  params: {
    name: servicePlanName
    location: servicePlanLocation
    sku: {
      capacity: 1
      family: 'B'
      name: 'B1'
      size: 'B1'
      tier: 'Basic'
      reserved: true
    }
  }
}

module webApp 'modules/web-app.bicep' = {
  name: 'webApp'
  params: {
    name: webAppName
    location: webAppLocation
    serverFarmResourceId: servicePlan.outputs.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|${containerRegistry.outputs.loginServer}/${containerRegistryImageName}:${containerRegistryImageVersion}'
      appCommandLine: ''
    }
    appSettingsKeyValuePairs: {
      WEBSITES_ENABLE_APP_SERVICE_STORAGE: false
      DOCKER_REGISTRY_SERVER_URL: containerRegistry.outputs.loginServer
    }
  }
}
