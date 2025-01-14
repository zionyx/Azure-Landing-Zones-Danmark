targetScope = 'managementGroup'
resource Deny_MachineLearning_Aks 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-MachineLearning-Aks'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'Deny AKS cluster creation in Azure Machine Learning'
    description: 'Deny AKS cluster creation in Azure Machine Learning and enforce connecting to existing clusters.'
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
            equals: 'Microsoft.MachineLearningServices/workspaces/computes'
          }
          {
            field: 'Microsoft.MachineLearningServices/workspaces/computes/computeType'
            equals: 'AKS'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.MachineLearningServices/workspaces/computes/resourceId'
                exists: false
              }
              {
                value: '[empty(field(\'Microsoft.MachineLearningServices/workspaces/computes/resourceId\'))]'
                equals: true
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