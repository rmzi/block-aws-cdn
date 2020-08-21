data "terraform_remote_state" "domain" {
  backend = "pg"

  workspace = length(split(var.parent_blocks.domain, ".")) == 3 ? replace(var.parent_blocks.domain, ".", "-") : "${var.stack_name}-${var.env}-${var.parent_blocks.domain}"

  config = {
    conn_str    = var.backend_conn_str
    schema_name = var.owner_id
  }
}
