terraform {
    backend "gcs" {
        bucket = "" #edit here
        prefix = "tfstate"
    }
}