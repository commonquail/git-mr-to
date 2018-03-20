#!/usr/bin/env bats

load helper

@test 'GitHub needs ?expand=1 to display merge request editor' {
    add_remote_with_provider origin github.com

    run git mr-to

    test "$status" -eq 0
    grep '?expand=1$' <<< "$output"
}

@test 'GitHub SSH' {
    add_remote_with_provider origin github.com

    run git mr-to origin foo bar

    test "$status" -eq 0
    test "$output" = 'https://github.com/namespace/project/compare/foo...namespace:bar?expand=1'
}

@test 'GitHub HTTPS' {
    add_remote_with_provider origin github.com

    run git mr-to origin foo bar

    test "$status" -eq 0
    test "$output" = 'https://github.com/namespace/project/compare/foo...namespace:bar?expand=1'
}

@test 'GitHub inter-project' {
    add_remote_with_provider --namespace base upstream github.com
    add_remote_with_provider --namespace fork origin   github.com

    run git mr-to upstream foo bar

    test "$status" -eq 0
    test "$output" = 'https://github.com/base/project/compare/foo...fork:bar?expand=1'
}
