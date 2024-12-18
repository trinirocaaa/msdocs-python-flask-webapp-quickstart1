@description('Deploy an Azure Web App for Linux Containers')
param name string
param location string
param serverFarmResourceId string
param containerRegistryName string
param containerRegistryImageName string
param containerRegistryImageVersion string
param dockerRegistryServerUrl string
@secure()
param dockerRegistryServerUsername string
@secure()
param dockerRegistryServerPassword string

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: name
  location: location
  kind: 'app'
  properties: {
    serverFarmId: serverFarmResourceId
    siteConfig: {
      linuxFxVersion: 'DOCKER|${containerRegistryName}.azurecr.io/${containerRegistryImageName}:${containerRegistryImageVersion}'
      appCommandLine: ''
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: dockerRegistryServerUrl
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: dockerRegistryServerUsername
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: dockerRegistryServerPassword
        }
      ]
    }
  }
}

output siteUrl string = 'https://${name}.azurewebsites.net'
