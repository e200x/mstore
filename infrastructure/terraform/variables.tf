variable "token" {
  description = "Yandex.Cloud token"
  type        = string
  nullable    = false
  sensitive   = true 
}

variable "cloud_id" {
  description = "Yandex.Cloud ID"
  type        = string
  nullable    = false
  sensitive   = true
  default     = ""
}

variable "folder_id" {
  description = "Yandex.Cloud Folder ID"
  type        = string
  nullable    = false
  sensitive   = true
  default     = ""
}

variable "zone" {
  description = "Yandex.Cloud Folder ID"
  type        = string
  nullable    = false
  sensitive   = true
  default     = "ru-central1-a"
}

variable "k8s_version" {
  description = "Yandex.Cloud k8s Version"
  type        = string
  nullable    = false
  default     = "1.23"
}

variable "sa_name" {
  description = "Yandex.Cloud Service Account name"
  type        = string
  nullable    = false
  sensitive   = true
  default     = "myaccount"
}

variable "node_core_count" {
  type        = number
  nullable    = false
  default     = 2
}

variable "core_fraction" {
  type        = number
  nullable    = false
  default     = 20
}

variable "memory" {
  type        = number
  nullable    = false
  default     = 2
}

variable "disk_type" {
  type        = string
  nullable    = false
  default     = "network-hdd"
}

variable "disk_size" {
  type        = number
  nullable    = false
  default     = 36
}

variable "preemptible_vm" {
  type        = bool
  nullable    = false
  default     = true
}