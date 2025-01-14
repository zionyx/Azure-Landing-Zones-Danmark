targetScope = 'managementGroup'
resource Deny_MachineLearning_PublicNetworkAccess 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-MachineLearning-PublicNetworkAccess'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'Azure Machine Learning should have disabled public network access'
    description: 'Denies public network access for Azure Machine Learning workspaces.'
    metadata: {
      version: '1.0.0'
      category: 'Machine Learning'
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
          'Disabled'
          'Deny'
        ]
        defaultValue: 'Deny'
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.MachineLearningServices/workspaces'
          }
          {
            field: 'Microsoft.MachineLearningServices/workspaces/publicNetworkAccess'
            notEquals: 'Disabled'
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}