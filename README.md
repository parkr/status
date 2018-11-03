# status

This is a repository hosting a status site for my various web properties.

This repository uses [sourcegraph/checkup](https://github.com/sourcegraph/checkup) to write to the `updates/` directory.

## Web

Normal usage of this repository is just visiting https://www.parkermoore.de/status/. It shows a lovely series of graphs for my web properties. It tracks up, down, and degraded states.

## Generating

This repo uses Jess Frazelle's Docker image, [r.j3ss.co/checkup](https://r.j3ss.co/checkup) to run `checkup`.

It is passed a configuration file like this:

```json
{
  "storage": {
    "provider": "github",
    "access_token": "some_api_access_token_with_repo_scope",
    "repository_owner": "owner",
    "repository_name": "repo",
    "committer_name": "Commiter Name",
    "committer_email": "you@yours.com",
    "branch": "gh-pages",
    "dir": "updates"
  },
  "checkers": [
    {
      "type": "http",
      "endpoint_name": "Example HTTP",
      "endpoint_url": "http://www.example.com"
    }
  ]
}
```

Then, I run checkup on a cron. It will automatically write to GitHub.
