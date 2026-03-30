# Training VM

EC2 instances pre-configured with training tools, one per student.

## Pre-installed tools

- AWS CLI v2
- kubectl
- OpenTofu
- gotemplate
- Nullplatform CLI

## Requirements

- OpenTofu >= 1.6
- AWS credentials configured
- Students' SSH public keys

## Usage

### 1. Initialize

```bash
tofu init
```

### 2. Add students

Edit `terraform.tfvars` and add each student with their SSH public key:

```hcl
students = {
  agustin = {
    ssh_public_key = "ssh-ed25519 AAAA... agustin@email.com"
  }
  maria = {
    ssh_public_key = "ssh-ed25519 AAAA... maria@email.com"
  }
  juan = {
    ssh_public_key = "ssh-rsa AAAA... juan@email.com"
  }
}
```

Each student needs to provide their public key. They can get it with:

```bash
cat ~/.ssh/id_ed25519.pub
# or
cat ~/.ssh/id_rsa.pub
```

### 3. Deploy

```bash
tofu plan    # review what will be created
tofu apply   # create the instances
```

The output shows the SSH command for each student:

```
student_connections = {
  agustin = { public_ip = "3.x.x.x", ssh_command = "ssh ubuntu@3.x.x.x" }
  maria   = { public_ip = "3.x.x.y", ssh_command = "ssh ubuntu@3.x.x.y" }
}
```

### 4. Connect

Each student connects with:

```bash
ssh ubuntu@<their-ip>
```

Tools are ready after ~3 minutes (cloud-init runs on first boot). Check progress with:

```bash
tail -f /var/log/cloud-init-output.log
```

### 5. Cleanup

```bash
tofu destroy
```
