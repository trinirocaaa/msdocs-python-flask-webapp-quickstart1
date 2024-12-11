@description('Deploy an Azure Container Registry')
param name string
param location string
param acrAdminUserEnabled bool

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: name
  location: location
  properties: {
    adminUserEnabled: acrAdminUserEnabled
  }
}

output containerRegistryLoginServer string = containerRegistry.properties.loginServer
