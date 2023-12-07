provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "DeliveryPipeline_rg" {
  name     = "DeliveryPipeline"
  location = "West Europe"
}

resource "azurerm_virtual_network" "DeliveryPipeline_vnet" {
  name                = "DeliveryPipelineVNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.DeliveryPipeline_rg.location
  resource_group_name = azurerm_resource_group.DeliveryPipeline_rg.name
}

resource "azurerm_subnet" "DeliveryPipeline_subnet" {
  name                 = "DeliveryPipelineSubnet"
  resource_group_name  = azurerm_resource_group.DeliveryPipeline_rg.name
  virtual_network_name = azurerm_virtual_network.DeliveryPipeline_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "DeliveryPipeline_nsg" {
  name                = "DeliveryPipelineNSG"
  location            = azurerm_resource_group.DeliveryPipeline_rg.location
  resource_group_name = azurerm_resource_group.DeliveryPipeline_rg.name
}

resource "azurerm_network_security_rule" "DeliveryPipeline_nsg_rule" {
  name                        = "HTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.DeliveryPipeline_rg.name
  network_security_group_name = azurerm_network_security_group.DeliveryPipeline_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "DeliveryPipeline_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.DeliveryPipeline_subnet.id
  network_security_group_id = azurerm_network_security_group.DeliveryPipeline_nsg.id
}

resource "azurerm_service_plan" "DeliveryPipeline_asp" {
  name                = "DeliveryPipelineAppServicePlan"
  location            = azurerm_resource_group.DeliveryPipeline_rg.location
  resource_group_name = azurerm_resource_group.DeliveryPipeline_rg.name

  os_type   = "Linux"   
  sku_name  = "B1"      
}

resource "azurerm_app_service" "DeliveryPipeline_app"{
  name                = "DeliveryPipelineAppService"
  location            = azurerm_resource_group.DeliveryPipeline_rg.location
  resource_group_name = azurerm_resource_group.DeliveryPipeline_rg.name
  app_service_plan_id = azurerm_service_plan.DeliveryPipeline_asp.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}