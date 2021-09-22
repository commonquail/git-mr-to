provider_ssh_url()
{
    printf 'git@%s:%s/project.git' "$1" "$2"
}

provider_https_url()
{
    printf 'https://%s/%s/project' "$1" "$2"
}

add_remote_with_provider()
{
    local url_provider=provider_https_url

    if [[ $1 = --ssh ]]; then
        url_provider=provider_ssh_url
        shift
    fi

    local ns=namespace
    if [[ $1 = --namespace ]]; then
        ns="$2"
        shift 2
    fi

    git remote add "$1" "$($url_provider "$2" "$ns")"
}

init_repo()
{
    export GIT_MR_TO_BROWSER='printf %s\n'
    export PATH="$BATS_TEST_DIRNAME/..:$PATH"

    git init --quiet "$BATS_TMPDIR/repo"
    cd "$BATS_TMPDIR/repo" || exit
    git config user.email foo@bar.baz
    git commit --quiet --allow-empty -m "Initial"
    git branch foo
    git branch bar
}

setup()
{
    init_repo
    load 'bats-support/load'
    load 'bats-assert/load'
}

teardown()
{
    rm -rf "$BATS_TMPDIR/repo"
}
