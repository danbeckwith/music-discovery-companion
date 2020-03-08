# music-discovery-companion
Serverless Web App which uses the Spotify API to enable music discovery and playlist curation.

## Switching to personal development env
- Ensure aws cli is configured correctly with a command like: `aws s3api list-buckets`
- Check NPM is configured to https://registry.npmjs.org/: `npm get registry`

# Info

## API

### Get Artist
Invoke with:
```
aws lambda invoke --function-name arn:aws:lambda:eu-west-1:757782070749:function:get-artist output.json
```

## Resources
Terraform bucket location: 
```
{
    "Location": "http://music-discovery-companion-terraform.s3.amazonaws.com/"
}
```
Lambda source code location:
```
{
    "Location": "http://music-discovery-companion-lambda-source.s3.amazonaws.com/"
}
```

## Commands
Bucket was created with: `aws s3api create-bucket --bucket music-discovery-companion-terraform --acl private --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1`

### Terraform

Initialising terraform for the first time: `terraform init -backend=true -get=true -backend-config="bucket=music-discovery-companion-terraform" -backend-config="key=default/tf/terraform.tfstate" -backend-config="region=eu-west-1" -reconfigure`

Now the backend config lives in `./terraform/backend.tf`, we can just run: `terraform init`


