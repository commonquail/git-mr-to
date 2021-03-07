# git-mr-to

`git-mr-to` is a plug-in command for Git that opens a Web browser at the URL
for creating a new merge request. It is optimized for workflows where topic
branches are merged directly to `master`, such as the popular *GitHub Flow*
[[github-flow]].

`git mr-to` has varying degrees of support for, in alphabetical order, the
following repository hosting services:

- Bitbucket
- GitHub
- GitLab

See [Provider support](#provider-support) for details.

**Table of Contents**

* [Usage](#usage)
    * [Provider support](#provider-support)
    * [Browser choice](#browser-choice)
* [Installation](#installation)
* [The name](#the-name)
* [License](#license)

## Usage

**Synopsis:**

    git mr-to [remote [destination [source]]]

`remote` names the remote against whose project URL to create the merge
request. If only a single remote is configured in the repository, all arguments
can be omitted to create a merge request from the current branch to the
`master` branch of the configured remote.

`destination` names the branch to merge into. If omitted it defaults to
`master`.

`source` names the branch to merge into `destination`. If omitted it defaults
to the current branch.

### Provider support

`git mr-to`'s functionality depends on the repository hosting service provider.
Here are all the supported providers and their limitations:

- **Bitbucket:** limited to intra-project merge requests. Inter-project merge
  requests are not supported because no working URL format for this scenario
  has been found.

- **GitHub:** full intra-project and inter-project merge request support.

- **GitLab:** limited to intra-project merge requests. Inter-project merge
  requests are not supported because the URL format for this scenario uses
  internal numerical project IDs instead of project names.

*Inter-project support* requires the downstream remote&mdash;i.e., your
fork&mdash;to be named `origin`. If a repository has multiple configured
remotes, none of which are named `origin`, `git mr-to` will not be able to
infer the upstream/downstream relationship. In that case it will issue
a warning but proceed, allowing the user to configure the merge request
manually.

### Browser choice

By default `git mr-to` opens the Web page using `git-web--browse(1)`. This can
be overridden using the environment variable `GIT_MR_TO_BROWSER`. For instance,
the following example merely prints out the merge request URL, in a technically
correct but obtuse way for demonstrational purpose:

```sh
$ GIT_MR_TO_BROWSER="printf %s\n" git mr-to
```

## Installation

Place `git-mr-to` somewhere in your `$PATH`. Git will automatically detect the
executable as a command and provide it as `git mr-to`. You can do this with
`make install`, optionally providing `PREFIX=<path>` to override the default
installation prefix of `$HOME/.local`.

The `completion.sh` script provides Bash completion. To install, copy it to
your completion user directory's `completions/` directory; default
`$HOME/.local/share/bash-completion/completions/`:

```sh
cp completion.sh $HOME/.local/share/bash-completion/completions/git-mr-to
```

## The name

The name of the executable is `git-mr-to`. The name of the project and the
command provided by the executable is `git mr-to`. "to" is a word; "mr" is
short for "merge request", the term for pro-actively submitting a change
proposal against some upstream in GitLab. This term was chosen over "pull
request", used by GitHub and Bitbucket, because "pull request" in Git
terminology means something specific that is not precisely what GitHub and
Bitbucket offer.

## License

Copyright &copy; 2018-2021 Mikkel Kjeldsen

This software is released under the GPLv2, on account of using components from
the Git project v2.16.2 released under the GPLv2 [[git-license]].

[git-license]: https://git.kernel.org/pub/scm/git/git.git/ "Official Git project repository"
[github-flow]: https://scottchacon.com/2011/08/31/github-flow.html "Original GitHub Flow description"
