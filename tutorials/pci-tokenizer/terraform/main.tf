provider "google" {
  project = "pcispanner"
}

resource "google_spanner_instance" "instance" {
  name             = "pcispanner"  # << be careful changing this in production
  config           = "regional-us-west4"
  display_name     = "PCI Spanner" 
  processing_units = 100
  labels = {
    "env" = "prod"
  }
}

resource "google_spanner_database" "database" {
  instance = google_spanner_instance.instance.name
  name     = "tokenizer"
  ddl = [
    "CREATE TABLE tokens (token STRING(MAX) NOT NULL, tokenType STRING(20) NOT NULL, created TIMESTAMP NOT NULL, updated TIMESTAMP,) PRIMARY KEY(token)",
  ]

  deletion_protection = false
}
