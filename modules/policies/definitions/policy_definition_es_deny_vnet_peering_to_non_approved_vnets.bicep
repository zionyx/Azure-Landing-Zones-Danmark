targetScope = 'managementGroup'
resource Deny_VNET_Peering_To_Non_Approved_VNETs 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-VNET-Peering-To-Non-Approved-VNETs'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Deny vNet peering to non-approved vNets'
    description: 'This policy denies the creation of vNet Peerings to non-approved vNets under the assigned scope.'
    metadata: {
      version: '1.0.0'
      category: 'Network'
    }
    parameters: {
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
      allowedVnets: {
        type: 'Array'
        metadata: {
          displayName: 'Allowed vNets to peer with'
          description: 'Array of allowed vNets that can be peered with. Must be entered using their resource ID. Example: /subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}'
        }
        defaultValue: []
      }
    }
    policyRule: {
      if: {
        anyOf: [
          {
            allOf: [
              {
                field: 'type'
                equals: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
              }
              {
                not: {
                  field: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings/remoteVirtualNetwork.id'
                  in: '[parameters(\'allowedVnets\')]'
                }
              }
            ]
          }
          {
            allOf: [
              {
                field: 'type'
                equals: 'Microsoft.Network/virtualNetworks'
              }
              {
                not: {
                  field: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings[*].remoteVirtualNetwork.id'
                  in: '[parameters(\'allowedVnets\')]'
                }
              }
              {
                not: {
                  field: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings[*].remoteVirtualNetwork.id'
                  exists: false
                }
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}