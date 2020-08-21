# block-aws-cdn

Nullstone Block provisions an AWS CloudFront Distribution (CDN) and an SSL Certificate against a subdomain chosen 

## Inputs

- `owner_id: string` - Stack Owner ID
- `stack_name: string` - Stack Name
- `block_name: string` - Block Name
- `parent_blocks: {origin: string, domain: string}` - Parent Blocks
  - origin represents a resource to forward requests through CDN
  - domain represents the source domain to host DNS records
- `env: string` - Environment Name
- `backend_conn_str: string` - Connection string for postgres backend

- `enable_www: bool` - (Default: true) Enable/Disable creating www.<domain> DNS record 
in addition to <subdomain> DNS record for site hosted on CDN
- `enable_404page: bool` - (Default: false) Enable/Disable custom 404 page within s3 bucket. If enabled, bucket must contain 404.html.

## Outputs

