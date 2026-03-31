variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "students" {
  type = map(object({
    ssh_public_key = string
  }))
  description = "Map of student name to their SSH public key"
}

variable "anthropic_api_key" {
  type        = string
  sensitive   = true
  description = "Anthropic API key for Claude Code CLI"
}

variable "allowed_ssh_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "CIDRs allowed to SSH into the instances"
}
