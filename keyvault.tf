# Récupération du tenant ID
data "azurerm_client_config" "current" {}

# Création du Key Vault
resource "azurerm_key_vault" "main" {
  name                = "tp2-keyvault-salem"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  # Droits pour votre compte Azure (Service Principal)
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete"
    ]
  }

  # Droits pour la VM (Managed Identity)
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_user_assigned_identity.main.principal_id

    secret_permissions = [
      "Get", "List"
    ]
  }
  access_policy {
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = "*************************"

  secret_permissions = [
    "Get", "List", "Set", "Delete"
  ]
 }
}

# Génération d'un secret aléatoire
resource "random_password" "secret" {
  length  = 32
  special = true
}

# Stockage du secret dans le Key Vault
resource "azurerm_key_vault_secret" "main" {
  name         = "tp2-secret"
  value        = random_password.secret.result
  key_vault_id = azurerm_key_vault.main.id
}

