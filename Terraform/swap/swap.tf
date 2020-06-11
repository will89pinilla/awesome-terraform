terraform {
     required_version = ">= 0.11" 
     backend "azurerm" {
         storage_account_name   = "__terraformstorageaccount__"
        container_name          = "terraform"
        key                     = "terraform.tfstate"
	    access_key              = "__storagekey__"
        features{}
    }
}

provider "azurerm" {
    version = "=2.0.0"
    features {}
}

resource "azurerm_resource_group" "slotDemo" {
    name = "slotDemoResourceGroup"
    location = "westus2"
}

resource "azurerm_app_service_plan" "slotDemo" {
    name                = "__appserviceplan__"
    location            = azurerm_resource_group.slotDemo.location
    resource_group_name = azurerm_resource_group.slotDemo.name
    sku {
        tier = "Standard"
        size = "S1"
    }
}

resource "azurerm_app_service" "slotDemo" {
    name                = "__appservicename__"
    location            = azurerm_resource_group.slotDemo.location
    resource_group_name = azurerm_resource_group.slotDemo.name
    app_service_plan_id = azurerm_app_service_plan.slotDemo.id
}

resource "azurerm_app_service_slot" "slotDemo" {
    name                = "__appservicenameslot__"
    location            = azurerm_resource_group.slotDemo.location
    resource_group_name = azurerm_resource_group.slotDemo.name
    app_service_plan_id = azurerm_app_service_plan.slotDemo.id
    app_service_name    = azurerm_app_service.slotDemo.name
}

# Swap the production slot and the staging slot
resource "azurerm_app_service_active_slot" "slotDemoActiveSlot" {    
    resource_group_name   = "slotDemoResourceGroup"    
    app_service_name      = "__appservicename__"
    app_service_slot_name = "__appservicenameslot__"
    
}
