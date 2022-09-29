targetScope = 'managementGroup'
resource Append_Redis_disableNonSslPort 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Append-Redis-disableNonSslPort'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'Azure Cache for Redis Append and the enforcement that enableNonSslPort is disabled.'
    description: 'Azure Cache for Redis Append and the enforcement that enableNonSslPort is disabled. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server.'
    metadata: {
      version: '1.0.0'
      category: 'Cache'
    }
    parameters: {
      effect: {
        type: 'String'
        defaultValue: 'Append'
        allowedValues: [
          'Append'
          'Disabled'
          'Modify'
        ]
        metadata: {
          displayName: 'Effect Azure Cache for Redis'
          description: 'Enable or disable the execution of the policy minimum TLS version Azure Cache for Redis'
        }
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Cache/redis'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.Cache/Redis/enableNonSslPort'
                equals: 'true'
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: [
          {
            field: 'Microsoft.Cache/Redis/enableNonSslPort'
            value: false
          }
        ]
      }
    }
  }
}