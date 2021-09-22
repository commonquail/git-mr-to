#!/usr/bin/env bats

load helper

# Providers here are not specifically important, however, GitHub's URL format
# is very clean, and it is currently the only provider with working
# inter-project merge request support.
some_provider=github.com
some_other_provider=bitbucket.org

@test 'fails with usage if no remote configured' {
    run git mr-to

    assert_failure
    assert_output --partial 'usage'
}

@test 'uses configured remote if only one configured' {
    add_remote_with_provider whatever $some_provider

    run git mr-to

    assert_success
    test -n "$output"
}

@test 'fails if multiple remotes configured and none specified' {
    add_remote_with_provider origin   $some_provider
    add_remote_with_provider upstream $some_provider

    run git mr-to

    assert_failure
    assert_output --partial 'ambiguous'
    assert_output --partial 'origin'
    assert_output --partial 'upstream'
}

@test 'uses specified remote' {
    add_remote_with_provider john $some_provider
    add_remote_with_provider jane $some_other_provider

    run git mr-to john

    assert_success
    assert_output --partial "$some_provider"
    refute_output --partial "$some_other_provider"
}

@test 'fails if non-existent remote specified' {
    run git mr-to foobar

    assert_failure
    assert_output --partial 'foobar'
}

@test "warns of ambiguous downstream fork if multiple remotes and no 'origin'" {
    add_remote_with_provider john $some_provider
    add_remote_with_provider jane $some_other_provider

    run git mr-to john

    assert_success
    assert_output --partial 'ambiguous'
    assert_output --partial 'could not infer downstream fork'
}

@test "assumes downstream fork namespace of 'origin' when merging to 'upstream'" {
    add_remote_with_provider --namespace fork origin   $some_provider
    add_remote_with_provider --namespace base upstream $some_provider

    run git mr-to upstream

    assert_success
    assert_output --partial 'base/project'
    assert_output --partial 'fork:master'
    refute_output --partial 'ambiguous'
}

@test "assumes downstream fork namespace of 'origin' when merging to 'origin'" {
    add_remote_with_provider --namespace fork origin   $some_provider
    add_remote_with_provider --namespace base upstream $some_provider

    run git mr-to origin

    assert_success
    assert_output --partial 'fork/project'
    assert_output --partial 'fork:master'
    refute_output --partial 'ambiguous'
}

@test "use 'master' as destination branch, current branch as source, when specifying remote" {
    add_remote_with_provider origin $some_provider

    git checkout foo

    run git mr-to origin

    assert_success
    assert_output --partial 'namespace/project'
    assert_output --partial 'compare/master'
    assert_output --partial 'namespace:foo'
}

@test 'use current branch as source when specifying destination remote and branch' {
    add_remote_with_provider origin $some_provider

    git checkout bar

    run git mr-to origin foo

    assert_success
    assert_output --partial 'namespace/project'
    assert_output --partial 'compare/foo'
    assert_output --partial 'namespace:bar'
}

@test 'can specify destination remote, destination branch, and source branch' {
    add_remote_with_provider origin $some_provider

    git checkout master

    run git mr-to origin foo bar

    assert_success
    assert_output --partial 'namespace/project'
    assert_output --partial 'compare/foo'
    assert_output --partial 'namespace:bar'
}
