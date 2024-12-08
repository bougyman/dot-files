export-env {
    use env.nu *
}

export use aliases.nu *
export use ($nu.home-path | path join "g" "dot-files" ".config" "nushell" "modules" "nupm" "nupm")
export use ($nu.home-path | path join "g" "dot-files" ".config" "nushell" "modules" "ai.nu" "ai") *

export use ($nu.home-path | path join "g" "dot-files" ".config" "nushell" "modules" "git.nu" "git") *
export use ($nu.home-path | path join "g" "dot-files" ".config" "nushell" "modules" "private-tools") *

# export use ($nu.home-path | path join "g" "dot-files" ".config" "nushell" "modules" "argx.nu" "argx")
# export use ($nu.home-path | path join "g" "dot-files" ".config" "nushell" "modules" "kubernetes.nu" "kubernetes") *
