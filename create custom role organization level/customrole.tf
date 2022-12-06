resource "google_organization_iam_custom_role" "my-custom-role" {
  role_id     = "terraformcustomrole1"
  org_id      = "772284654262"
  title       = "terraform1"
  description = "A description"
  permissions = ["billing.accounts.close", "billing.accounts.get", "billing.accounts.getCarbonInformation", "billing.accounts.getIamPolicy", "billing.accounts.getPaymentInfo", "billing.accounts.getPricing", "billing.accounts.getSpendingInformation", "billing.accounts.getUsageExportSpec", "billing.accounts.list", "billing.accounts.move", "compute.acceleratorTypes.get", "compute.acceleratorTypes.list", "compute.addresses.create", "compute.addresses.createInternal", "compute.addresses.delete", "compute.addresses.deleteInternal", "compute.addresses.get", "compute.addresses.list", "compute.addresses.setLabels", "compute.addresses.use", "resourcemanager.organizations.get", "resourcemanager.projects.create"]
}
