#!/usr/bin/env bats

load helper

# Providers here are not specifically important, however, GitHub's URL format
# is very clean, and it is currently the only provider with working
# inter-project merge request support.
some_provider=github.com
some_other_provider=bitbucket.org

@test 'fails with usage if no remote configured' {
    run git mr-to

    test "$status" -eq 1
    grep 'usage' <<< "$output"
}

@test 'uses configured remote if only one configured' {
    add_remote_with_provider whatever $some_provider

    run git mr-to

    test "$status" -eq 0
    test -n "$output"
}

@test 'fails if multiple remotes configured and none specified' {
    add_remote_with_provider origin   $some_provider
    add_remote_with_provider upstream $some_provider

    run git mr-to

    test "$status" -eq 1
    grep 'ambiguous' <<< "$output"
    grep 'origin'    <<< "$output"
    grep 'upstream'  <<< "$output"
}

@test 'uses specified remote' {
    add_remote_with_provider john $some_provider
    add_remote_with_provider jane $some_other_provider

    run git mr-to john

    test "$status" -eq 0
    grep "$some_provider" <<< "$output"
    grep -v "$some_other_provider" <<< "$output"
}

@test 'fails if non-existent remote specified' {
    run git mr-to foobar

    test "$status" -ne 0
    grep 'foobar' <<< "$output"
}

@test "warns of ambiguous downstream fork if multiple remotes and no 'origin'" {
    add_remote_with_provider john $some_provider
    add_remote_with_provider jane $some_other_provider

    run git mr-to john

    test "$status" -eq 0
    grep 'ambiguous' <<< "$output"
    grep 'could not infer downstream fork' <<< "$output"
}

@test "assumes downstream fork namespace of 'origin' when merging to 'upstream'" {
    add_remote_with_provider --namespace fork origin   $some_provider
    add_remote_with_provider --namespace base upstream $some_provider

    run git mr-to upstream

    test "$status" -eq 0
    grep 'base/project' <<< "$output"
    grep 'fork:master'  <<< "$output"
    grep -v 'ambiguous' <<< "$output"
}

@test "assumes downstream fork namespace of 'origin' when merging to 'origin'" {
    add_remote_with_provider --namespace fork origin   $some_provider
    add_remote_with_provider --namespace base upstream $some_provider

    run git mr-to origin

    test "$status" -eq 0
    grep 'fork/project' <<< "$output"
    grep 'fork:master'  <<< "$output"
    grep -v 'ambiguous' <<< "$output"
}

@test "use 'master' as destination branch, current branch as source, when specifying remote" {
    add_remote_with_provider origin $some_provider

    git checkout foo

    run git mr-to origin

    test "$status" -eq 0
    grep 'namespace/project' <<< "$output"
    grep 'compare/master' <<< "$output"
    grep 'namespace:foo' <<< "$output"
}

@test 'use current branch as source when specifying destination remote and branch' {
    add_remote_with_provider origin $some_provider

    git checkout bar

    run git mr-to origin foo

    test "$status" -eq 0
    grep 'namespace/project' <<< "$output"
    grep 'compare/foo' <<< "$output"
    grep 'namespace:bar' <<< "$output"
}

@test 'can specify destination remote, destination branch, and source branch' {
    add_remote_with_provider origin $some_provider

    git checkout master

    run git mr-to origin foo bar

    test "$status" -eq 0
    grep 'namespace/project' <<< "$output"
    grep 'compare/foo' <<< "$output"
    grep 'namespace:bar' <<< "$output"
}
