output "vm_public_ip" {
  value = 20.251.160.134
}

output "sql_server_endpoint" {
  value = azurerm_sql_server.example.fully_qualified_domain_name
}

output "sql_database_name" {
  value = azurerm_sql_database.example.name
}
