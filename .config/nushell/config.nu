$env.config = {
    show_banner: false,
    history: {
        max_size: 1_000_000
        sync_on_enter: true
        file_format: "sqlite"
        isolation: true
    },
    hooks: {
        pre_prompt: [{ ||
            if (which direnv | is-empty) {
                return
            }

            direnv export json | from json | default {} | load-env
            if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
               $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
            }
        }]
    }
}

export-env {
    $env.MISE_SHELL = "nu"
    let mise_hook = {
      condition: { "MISE_SHELL" in $env }
      code: { mise_hook }
    }
    add-hook hooks.pre_prompt $mise_hook
    add-hook hooks.env_change.PWD $mise_hook
}

def --env add-hook [field: cell-path new_hook: any] {
    let old_config = $env.config? | default {}
    let old_hooks = $old_config | get $field --ignore-errors | default []
    $env.config = ($old_config | upsert $field ($old_hooks ++ $new_hook))
}

def "parse vars" [] {
    $in | from csv --noheaders --no-infer | rename 'op' 'name' 'value'
}

export def --env --wrapped main [command?: string, --help, ...rest: string] {
    let commands = ["deactivate", "shell", "sh"]

    if ($command == null) {
        ^"/usr/bin/mise"
    } else if ($command == "activate") {
       $env.MISE_SHELL = "nu"
    } else if ($command in $commands) {
        ^"/usr/bin/mise" $command ...$rest
            | parse vars
            | update-env
    } else {
        ^"/usr/bin/mise" $command ...$rest
    }
}

def --env "update-env" [] {
    for $var in $in {
        if $var.op == "set" {
            load-env {($var.name): $var.value}
        } else if $var.op == "hide" {
            hide-env $var.name
        }
    }
}

def --env mise_hook [] {
    ^"/usr/bin/mise" hook-env -s nu
        | parse vars
        | update-env
}

use ($nu.home-path | path join "g" "dot-files" ".config" "nushell" "priv") *

source ~/.zoxide.nu

source ~/.cache/carapace/init.nu

# vim: set syntax=nu et sw=4 sts=4 ts=4 :
