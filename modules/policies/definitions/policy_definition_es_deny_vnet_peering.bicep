targetScope = 'managementGroup'
resource Deny_VNet_Peering 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-VNet-Peering'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Deny vNet peering '
    description: 'This policy denies the creation of vNet Peerings under the assigned scope.'
    metadata: {
      version: '1.0.1'
      category: 'Network'
    }
    parameters: {
      effect: {
        type: 'String'
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
      }
    }
    policyRule: {
      if: {
        field: 'type'
        equals: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}