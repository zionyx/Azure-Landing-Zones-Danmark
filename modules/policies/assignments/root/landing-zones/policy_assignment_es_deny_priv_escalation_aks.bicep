targetScope = 'managementGroup'
resource Deny_Priv_Escalation_AKS 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-Priv-Escalation-AKS'
  properties: {
    description: 'Do not allow containers to run with privilege escalation to root in a Kubernetes cluster. This recommendation is part of CIS 5.2.5 which is intended to improve the security of your Kubernetes environments. This policy is generally available for Kubernetes Service (AKS), and preview for AKS Engine and Azure Arc enabled Kubernetes. For more information, see https://aka.ms/kubepolicydoc.'
    displayName: 'Kubernetes clusters should not allow container privilege escalation'
    notScopes: []
    parameters: {
      effect: {
        value: 'deny'
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '1c6e92c9-99f0-4e55-9cf2-0c234dc48f99')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}