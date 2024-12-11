@description('Deploy an Azure Container Registry')
param name string
param location string
param sku string = 'Basic' // Default to Basic SKU
param acrAdminUserEnabled bool = false

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: name
  location: location
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: acrAdminUserEnabled
  }
}

output loginServer string = containerRegistry.properties.loginServer
output adminUsername string = listCredentials(containerRegistry.id, '2023-07-01').username
output adminPassword string = listCredentials(containerRegistry.id, '2023-07-01').passwords[0].value
