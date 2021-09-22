#!/usr/bin/env bats

load helper

@test 'Azure DevOps SSH' {
    git remote add origin git@ssh.dev.azure.com:v3/user/project/repo

    run git mr-to origin foo bar

    assert_success
    assert_output 'https://dev.azure.com/user/project/_git/repo/pullrequestcreate?sourceRef=bar&targetRef=foo'
}

@test 'Azure DevOps Visual Studio SSH' {
    git remote add origin user@vs-ssh.visualstudio.com:v3/user/project/repo

    run git mr-to origin foo bar

    assert_success
    assert_output 'https://dev.azure.com/user/project/_git/repo/pullrequestcreate?sourceRef=bar&targetRef=foo'
}

@test 'Azure DevOps HTTPS with user' {
    git remote add origin https://user@dev.azure.com/user/project/_git/repo

    run git mr-to origin foo bar

    assert_success
    assert_output 'https://dev.azure.com/user/project/_git/repo/pullrequestcreate?sourceRef=bar&targetRef=foo'
}

@test 'Azure DevOps HTTPS without user' {
    git remote add origin https://dev.azure.com/user/project/_git/repo

    run git mr-to origin foo bar

    assert_success
    assert_output 'https://dev.azure.com/user/project/_git/repo/pullrequestcreate?sourceRef=bar&targetRef=foo'
}

@test 'Azure DevOps inter-project' {
    skip 'format of destination project specification unknown'
}
