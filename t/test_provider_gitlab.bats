#!/usr/bin/env bats

load helper

@test 'GitLab SSH' {
    add_remote_with_provider --ssh origin gitlab.com

    run git mr-to origin foo bar

    test "$status" -eq 0
    test "$output" = 'https://gitlab.com/namespace/project/merge_requests/new?merge_request%5Bsource_branch%5D=bar&merge_request%5Btarget_branch%5D=foo'
}

@test 'GitLab HTTPS' {
    add_remote_with_provider origin gitlab.com

    run git mr-to origin foo bar

    test "$status" -eq 0
    test "$output" = 'https://gitlab.com/namespace/project/merge_requests/new?merge_request%5Bsource_branch%5D=bar&merge_request%5Btarget_branch%5D=foo'
}

@test 'GitLab HTTPS strips optional credentials-part user' {
    add_remote_with_provider origin baz@gitlab.com

    run git mr-to origin foo bar

    test "$status" -eq 0
    grep 'https://gitlab.com/' <<< "$output"
}

@test 'GitLab inter-project' {
    skip 'destination project specified by internal numerical project ID'
}
