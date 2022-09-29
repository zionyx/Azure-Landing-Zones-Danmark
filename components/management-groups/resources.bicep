targetScope = 'tenant'

param rootManagementGroupDisplayName string = 'Azure Landing Zones'
param prefix string
param canary bool = false
param enableConfidential bool = false

resource tenantRoot 'Microsoft.Management/managementGroups@2021-04-01' existing = {
  name: tenant().tenantId
}

resource root 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: canary ? '${prefix}-canary' : prefix
  properties: {
    displayName: canary ? '${rootManagementGroupDisplayName} - Canary' : rootManagementGroupDisplayName
    details: {
      parent: {
        id: tenantRoot.id
      }
    }
  }
}

resource decommissioned 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: canary ? '${prefix}-decommissioned-canary' : '${prefix}-decommissioned'
  properties: {
    displayName: 'Decommissioned'
    details: {
      parent: {
        id: root.id
      }
    }
  }
}

resource landingZones 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: canary ? '${prefix}-landing-zones-canary' : '${prefix}-landing-zones'
  properties: {
    displayName: 'Landing Zones'
    details: {
      parent: {
        id: root.id
      }
    }
  }
}

resource corp 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: canary ? '${prefix}-landing-zones-corp-canary' : '${prefix}-landing-zones-corp'
  properties: {
    displayName: 'Corp'
    details: {
      parent: {
        id: landingZones.id
      }
    }
  }
}

resource online 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: canary ? '${prefix}-landing-zones-online-canary' : '${prefix}-landing-zones-online'
  properties: {
    displayName: 'Online'
    details: {
      parent: {
        id: landingZones.id
      }
    }
  }
}

resource confidentialCorp 'Microsoft.Management/managementGroups@2021-04-01' = if (enableConfidential) {
  name: canary ? '${prefix}-landing-zones-confidential-corp-canary' : '${prefix}-landing-zones-confidential-corp'
  properties: {
    displayName: 'Confidential Corp'
    details: {
      parent: {
        id: landingZones.id
      }
    }
  }
}

resource confidentialOnline 'Microsoft.Management/managementGroups@2021-04-01' = if (enableConfidential) {
  name: canary ? '${prefix}-landing-zones-confidential-online-canary' : '${prefix}-landing-zones-confidential-online'
  properties: {
    displayName: 'Confidential Online'
    details: {
      parent: {
        id: landingZones.id
      }
    }
  }
}

resource platform 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: canary ? '${prefix}-platform-canary' : '${prefix}-platform'
  properties: {
    displayName: 'Platform'
    details: {
      parent: {
        id: root.id
      }
    }
  }
}

resource connectivity 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: canary ? '${prefix}-platform-connectivity-canary' : '${prefix}-platform-connectivity'
  properties: {
    displayName: 'Connectivity'
    details: {
      parent: {
        id: platform.id
      }
    }
  }
}

resource identity 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: canary ? '${prefix}-platform-identity-canary' : '${prefix}-platform-identity'
  properties: {
    displayName: 'Identity'
    details: {
      parent: {
        id: platform.id
      }
    }
  }
}

resource management 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: canary ? '${prefix}-platform-management-canary' : '${prefix}-platform-management'
  properties: {
    displayName: 'Management'
    details: {
      parent: {
        id: platform.id
      }
    }
  }
}

resource sandbox 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: canary ? '${prefix}-sandbox-canary' : '${prefix}-sandbox'
  properties: {
    displayName: 'Sandbox'
    details: {
      parent: {
        id: root.id
      }
    }
  }
}