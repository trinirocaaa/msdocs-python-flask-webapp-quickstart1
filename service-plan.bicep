@description('Deploy an Azure Service Plan')
param name string
param location string = resourceGroup().location

resource servicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: name
  location: location
  sku: {
    name: 'B1'
    tier: 'Premium'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  properties: {
    reserved: true // Linux-specific
  }
}

output serverFarmResourceId string = servicePlan.id
