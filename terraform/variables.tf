variable "resource_group_name" {
  description = "DeliveryPipeline"
  type        = string
  default     = "DeliveryPipeline"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "Norway East"
}

variable "container_registry_name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = "exampleacr"
}

variable "app_service_plan_name" {
  description = "Name of the Azure App Service Plan"
  type        = string
  default     = "example-appservice-plan"
}

variable "app_service_plan_tier" {
  description = "Tier of the Azure App Service Plan"
  type        = string
  default     = "Basic"
}

variable "app_service_plan_size" {
  description = "Size of the Azure App Service Plan"
  type        = string
  default     = "B1"
}

variable "web_app_name" {
  description = "Name of the Azure Web App"
  type        = string
  default     = "example-webapp"
}

variable "acr_sku" {
  description = "SKU of the Azure Container Registry"
  type        = string
  default     = "Basic"
}

variable "linux_fx_version" {
  description = "Linux function container version for the Azure Web App"
  type        = string
  default     = "DOCKER|${azurerm_container_registry.example.login_server}/example:latest"
}
