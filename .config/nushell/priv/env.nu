export-env {
  $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }
  $env.NUPM_HOME = ($nu.home-path | path join ".config" "nushell" "packages")
}
