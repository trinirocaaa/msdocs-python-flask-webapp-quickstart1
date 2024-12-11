param name string
param location string
param sku object

resource servicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: name
  location: location
  sku: sku
}

output id string = servicePlan.id
