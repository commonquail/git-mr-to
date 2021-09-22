#!/usr/bin/env bats

load helper

@test 'Bitbucket SSH' {
    add_remote_with_provider --ssh origin bitbucket.org

    run git mr-to origin foo bar

    assert_success
    assert_output 'https://bitbucket.org/namespace/project/pull-requests/new?source=bar&dest=foo'
}

@test 'Bitbucket HTTPS' {
    add_remote_with_provider origin bitbucket.org

    run git mr-to origin foo bar

    assert_success
    assert_output 'https://bitbucket.org/namespace/project/pull-requests/new?source=bar&dest=foo'
}

@test 'Bitbucket HTTPS strips optional credentials-part user' {
    add_remote_with_provider origin baz@bitbucket.org

    run git mr-to origin foo bar

    assert_success
    assert_output --partial 'https://bitbucket.org/'
}

@test 'Bitbucket inter-project' {
    skip 'format of destination project specification unknown'
}
