# block-aws-cdn

Nullstone Block provisions an AWS CloudFront Distribution (CDN) and an SSL Certificate against a subdomain chosen 

## Inputs

- `owner_id: string` - Stack Owner ID
- `stack_name: string` - Stack Name
- `block_name: string` - Block Name
- `parent_blocks: {}` - Parent Blocks
- `env: string` - Environment Name
- `backend_conn_str: string` - Connection string for postgres backend

## Outputs

