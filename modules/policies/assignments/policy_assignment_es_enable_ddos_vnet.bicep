targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param ddosPlan string

module Enable_DDoS_VNET '../modules/policy-and-role-assignment.bicep' = {
  name: 'Enable-DDoS-VNET-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Enable-DDoS-VNET'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '94de2ad3-e0c1-4caf-ad78-5d47bbc83d3d')
    location: location
    parameters: {
      effect: {
        value: 'Modify'
      }
      ddosPlan: {
        value: ddosPlan
      }
    }
  }
}
