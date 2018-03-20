#!/usr/bin/env bats

load helper

@test 'GitLab SSH' {
    add_remote_with_provider origin gitlab.com

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

@test 'GitLab inter-project' {
    skip 'destination project specified by internal numerical project ID'
}
