@description('Deploy an Azure Service Plan')
param name string
param location string

resource servicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: name
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  kind: 'Linux'
  properties: {
    reserved: true
  }
}

output serverFarmResourceId string = servicePlan.id
