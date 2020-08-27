# Optic Auto API Documentation Commentator

See your latest API Specification for every single pull request

## Prerequisites

- An Optic Project. Make one [here!](https://app.useoptic.com)

## Usage

Simply add Optic to your pull request workflow. Requires `GITHUB_TOKEN` to comment on prs.


`.github/workflows/optic.yml`

```yaml
name: Optic Pull Request Bot
on: [pull_request]
jobs:
  optic_pr:
    runs-on: ubuntu-latest
    steps:
      - name: Optic PR Bot
        uses: trulyronak/gitbot@0.01
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

All inputs can be passed in with the 

### `head`

The branch to compare with base. Defaults to `${{ github.head_ref }}`, or the branch that spurred the `pull_request` event.

### `repository`

The repository to be running this on. Defaults to the current repository.