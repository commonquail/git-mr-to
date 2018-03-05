# git-mr-to

`git-mr-to` is a plug-in command for Git that opens a Web browser at the URL
for creating a new merge request. It supports, in alphabetical order, the
following repository hosting services:

- Bitbucket
- GitHub
- GitLab

**Table of Contents**

* [Usage](#usage)
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

## Installation

Place `git-mr-to` somewhere in your `$PATH`. Git will automatically detect the
executable as a command and provide it as `git mr-to`.

For bash completion, source `completion.sh` from `$HOME/.bash_completion`:

```sh
source $HOME/src/git-mr-to/completion.sh
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

Copyright &copy; 2018 Mikkel Kjeldsen

This software is released under the GPLv2, on account of using components from
the Git project v2.16.2 released under the GPLv2 [[git-license]].

[git-license]: https://git.kernel.org/pub/scm/git/git.git/ "Official Git project repository"
