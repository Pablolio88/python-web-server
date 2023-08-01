resource "aws_s3_bucket" "this" {
  count = var.create ? 1 : 0

  bucket        = var.name
  bucket_prefix = var.bucket_prefix

  force_destroy = var.force_destroy
  tags          = merge({ "Name" = coalesce(var.name, var.bucket_prefix) }, var.tags)

}

locals {
  versioning_state            = var.enable_versioning ? "Enabled" : (var.suppress_versioning ? "Suspended" : "Disabled")
  versioning_mfa_delete_state = var.force_mfa_on_versions ? "Enabled" : local.versioning_state != "Disabled" && var.mfa != null ? "Disabled" : null
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.create ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  versioning_configuration {
    status     = local.versioning_state
    mfa_delete = local.versioning_mfa_delete_state
  }
  mfa = var.mfa
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.create ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.server_side_encryption_algoritm
      kms_master_key_id = var.server_side_encryption_kms_master_key_id
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this_block_public" {
  count = var.create && var.acl == "private" ? 1 : 0

  bucket                  = aws_s3_bucket.this[count.index].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = true
}