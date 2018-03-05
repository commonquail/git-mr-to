_git_mr_to()
{
    # $cword, $cur, and $prev are provided by the Git completion framework.
    # shellcheck disable=2154
    if [ "$cword" -eq 2 ]; then
	__gitcomp_nl "$(__git_remotes)"
    elif [ "$cword" -eq 3 ]; then
        __git_complete_refs --remote="$prev" --cur="$cur"
    else
        __gitcomp_direct "$(__git_heads "" "$cur" " ")"
    fi
}
