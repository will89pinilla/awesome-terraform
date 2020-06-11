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

# Swap the production slot and the staging slot
resource "azurerm_app_service_active_slot" "slotDemoActiveSlot" {
    resource_group_name   = "slotDemoResourceGroup"
    app_service_name      = "__appservicename__"
    app_service_slot_name = "__appservicenameslot__"
}
