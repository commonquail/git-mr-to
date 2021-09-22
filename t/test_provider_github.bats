#!/usr/bin/env bats

load helper

@test 'GitHub needs ?expand=1 to display merge request editor' {
    add_remote_with_provider origin github.com

    run git mr-to

    assert_success
    assert_output --partial '?expand=1'
}

@test 'GitHub SSH' {
    add_remote_with_provider --ssh origin github.com

    run git mr-to origin foo bar

    assert_success
    assert_output 'https://github.com/namespace/project/compare/foo...namespace:bar?expand=1'
}

@test 'GitHub HTTPS' {
    add_remote_with_provider origin github.com

    run git mr-to origin foo bar

    assert_success
    assert_output 'https://github.com/namespace/project/compare/foo...namespace:bar?expand=1'
}

@test 'GitHub HTTPS strips optional credentials-part user' {
    add_remote_with_provider origin baz@github.com

    run git mr-to origin foo bar

    assert_success
    assert_output --partial 'https://github.com/'
}

@test 'GitHub inter-project' {
    add_remote_with_provider --namespace base upstream github.com
    add_remote_with_provider --namespace fork origin   github.com

    run git mr-to upstream foo bar

    assert_success
    assert_output 'https://github.com/base/project/compare/foo...fork:bar?expand=1'
}
