# OCI Frontend and Backend for DevOps

Deploy with Terraform and Ansible your frontend (React.js) and backend (Node.js) on OCI.

## Requirements

- Oracle Cloud Infrastructure account
- OCI CLI, Terraform and Ansible configured.

## TODO

- LB Health Checks in warning
- Ansible merge frontend and backend in one
- Frontend and Backend on private subnets
- Add Database

## Set Up

```
git clone https://github.com/vmleon/oci-fe-be-devops.git
```

```
cd oci-fe-be-devops
```

```
export BASE_DIR=$(pwd)
```

## Build

```
cd $BASE_DIR/src/frontend
```

```
npm install
```

```
npm run build
```

## Deploy

```
oci session authenticate
```

```
cd $BASE_DIR/deploy/terraform
```

```
cp terraform.tfvars.template terraform.tfvars
```

Edit the variables values:
```
vim terraform.tfvars
```

```
terraform apply -auto-approve
```

```
ansible-playbook -i generated/app.ini ../ansible/frontend/frontend.yaml
```

> If you are asked:
> `Are you sure you want to continue connecting (yes/no/[fingerprint])?`
> Type `yes` and `[ENTER]`.

```
ansible-playbook -i generated/app.ini ../ansible/backend/backend.yaml
```

## Clean Up

```
terraform destroy -auto-approve
```