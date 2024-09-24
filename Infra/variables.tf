variable "location" {
  description = "The azure region which we will select for this project"
}

variable "resource_group_name" {
  description = "The name of the resource group in which we will create storage account"
}

variable "storage_account_name" {
  description = "The name of the storage account"
}

variable "source_content" {
  description = "The content of the index.html file"
}

variable "index_document" {
  description = "The name of the index document"
}

variable "client_id" {
  description = "The Client ID of the Service Principal."
  type        = string
}

variable "client_secret" {
  description = "The Client Secret of the Service Principal."
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID."
  type        = string
}

variable "subscription_id" {
  description = "The Subscription ID."
  type        = string
}