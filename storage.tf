# Compte de stockage
resource "azurerm_storage_account" "main" {
  name                     = "tp2storagesalem"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Conteneur Blob
resource "azurerm_storage_container" "main" {
  name                  = "tp2-container"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

# Identité managée pour la VM
resource "azurerm_user_assigned_identity" "main" {
  name                = "tp2-vm-identity"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

# Attribution du rôle Blob Storage à l'identité
resource "azurerm_role_assignment" "main" {
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.main.principal_id
}
