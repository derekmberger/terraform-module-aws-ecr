# terraform-module-aws-ecr
## ECR With Cross‑Account Policy Module

A reusable Terraform module that provisions an **Amazon ECR repository** and
attaches a repository policy that grants **pull‑only** access to:

1. **The current AWS account** (always).
2. **Specific external accounts** you list by account‑root ARN (optional).
3. **Every account in an AWS Organization** you specify by Org ID (optional).

It also supports an optional *repository‑protection* flag that disables
`force_delete`, preventing accidental deletions of production repositories.

---

## Usage

```hcl
module "ecr" {
  source = "github.com/biotornic/terraform‑module‑aws-ecr" #this should likely be a module in your TFC registry

  # Required
  ecr_repo_name = "shared‑app"

  # Optional – explicit allow‑list of accounts (root ARNs)
  allowed_account_roots = [
    "arn:aws:iam::111122223333:root",
    "arn:aws:iam::444455556666:root"
  ]

  # Optional – allow everyone in your AWS Organization
  principal_org_id = "o‑a1b2c3d4e5"

  # Optional – protect repo from terraform destroy
  repo_protection = true
}
```

---

## Variables

| Name                    | Type           | Default | Description                                                                          |
| ----------------------- | -------------- | ------- | ------------------------------------------------------------------------------------ |
| `ecr_repo_name`         | `string`       | **n/a** | Name of the ECR repository to create/manage.                                         |
| `allowed_account_roots` | `list(string)` | `[]`    | Account‑root ARNs (e.g., `arn:aws:iam::111122223333:root`) that may pull images.     |
| `principal_org_id`      | `string`       | `""`    | AWS Organizations ID whose member accounts may pull (e.g., `o‑abc123xyz`).           |
| `repo_protection`       | `bool`         | `false` | If `true`, sets `force_delete = false` to protect the repo from `terraform destroy`. |

---

## Outputs

| Name              | Description                                                                      |
| ----------------- | -------------------------------------------------------------------------------- |
| `repository_arn`  | ARN of the ECR repository.                                                       |
| `repository_url`  | Full registry/repository URL for `docker pull`.                                  |
| `image_tag`       | Default image tag (passthrough of `var.ecr_image_tag`).                          |
| `repository_info` | Object with `arn` and `url` keys—handy for passing as a single variable.         |
| `policy_json`     | Final JSON repository policy (useful for auditing/debugging).                    |

---

## How the Policy Works

* **Local‑account statement** – Always present, allows the account that owns
  the repo to pull images.
* **Account list statement** – Added only when `allowed_account_roots` is a
  non‑empty list. Grants pull actions to each specified account.
* **Org‑wide statement** – Added only when `principal_org_id` is non‑empty.
  Grants pull actions to all accounts whose `aws:PrincipalOrgID` matches.

If you supply both optional variables the policy contains **three statements**.
AWS evaluates them with logical **OR**—meeting any statement is sufficient.
