param webAppName string = uniqueString(resourceGroup().id)// Generate unique String for web app name
param sku string = 'S1' // The SKU of App Service Plan
param location string = resourceGroup().location

var appServicePlanName = toLower('AppServicePlan-${webAppName}')

resource acr 'Microsoft.ContainerRegistry/registries@2021-09-01' = {
  name: 'crdavidr'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: false
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'app'
}
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webAppName
  kind: 'app'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      
    }
  }
}
