#!/usr/bin/env bats

load helper

@test 'Bitbucket SSH' {
    add_remote_with_provider --ssh origin bitbucket.org

    run git mr-to origin foo bar

    test "$status" -eq 0
    test "$output" = 'https://bitbucket.org/namespace/project/pull-requests/new?source=bar&dest=foo'
}

@test 'Bitbucket HTTPS' {
    add_remote_with_provider origin bitbucket.org

    run git mr-to origin foo bar

    test "$status" -eq 0
    test "$output" = 'https://bitbucket.org/namespace/project/pull-requests/new?source=bar&dest=foo'
}

@test 'Bitbucket inter-project' {
    skip 'format of destination project specification unknown'
}
