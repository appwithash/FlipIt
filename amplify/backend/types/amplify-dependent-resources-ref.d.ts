export type AmplifyDependentResourcesAttributes = {
    "auth": {
        "flipit57159950": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string"
        }
    },
    "function": {
        "S3Trigger585c4647": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "usersLamdafunction": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        }
    },
    "storage": {
        "s3d6f0a568": {
            "BucketName": "string",
            "Region": "string"
        }
    },
    "api": {
        "api9705ffc5": {
            "RootUrl": "string",
            "ApiName": "string",
            "ApiId": "string"
        },
        "FlipIt": {
            "GraphQLAPIKeyOutput": "string",
            "GraphQLAPIIdOutput": "string",
            "GraphQLAPIEndpointOutput": "string"
        }
    }
}