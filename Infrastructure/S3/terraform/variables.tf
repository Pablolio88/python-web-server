variable "create" {
  description = "Create or not resources"
  type        = bool
}

variable "name" {
  description = "The name of the bucket. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "bucket_prefix" {
  description = "Creates a unique bucket name beginning with the specified prefix. Conflicts with `name`."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}

variable "enable_versioning" {
  description = "Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket."
  type        = bool
  default     = false
}

variable "suppress_versioning" {
  description = "Suppress versioning if it was enabled previously. See enable_versioning variable for detail."
  type        = bool
  default     = false
}

variable "server_side_encryption_algoritm" {
  description = "The server-side encryption algorithm to use. Valid values are AES256 and aws:kms. Defaults is `AES256`."
  type        = string
  default     = "AES256"
}

variable "server_side_encryption_kms_master_key_id" {
  description = "The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms."
  type        = string
  default     = null
}

variable "force_mfa_on_versions" {
  description = "Enable MFA delete for either Change the versioning state of your bucket or Permanently delete an object version. Default is false."
  type        = bool
  default     = false
}

variable "mfa" {
  description = "MFA device to enforce on version delete"
  type        = string
  default     = null
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "acl" {
  description = "The canned ACL to apply. Defaults to `private`."
  type        = string
  default     = "private"
}
