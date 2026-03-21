# yc-folder

Terraform module for creating a Yandex Cloud folder.

## Requirements

```bash
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=your_cloud_id
```

## Usage

See [terragrunt.example.hcl](./terragrunt.example.hcl) for a full example.

> **Bootstrap note:** This module provisions foundational infrastructure.
> Use local backend until your S3 state bucket exists.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
