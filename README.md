# Optic Auto API Documentation Commentator

See your latest API Specification for every single pull request

## Prerequisites

- An Optic Project. [Get Started](https://app.useoptic.com)

## Usage

Simply create a new pull request workflow

`.github/workflows/optic.yml`

```yml
name: Comment Spec url on PR
on: [pull_request]
jobs:
  optic_pr:
    runs-on: ubuntu-latest
    steps:
      - uses: trulyronak/gitbot@0.01
        with:
            repository: trulyronak/gitbot
            branch: ${{ github.head_ref }}
            head: main
        id: generate_spec
      - name: Comment on PR
        uses: unsplash/comment-on-pr@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          msg: ${{ steps.generate_spec.outputs.message }}
          check_for_duplicate_msg: false
```

## Inputs

### `branch`

**Required** The branch to checkout
**Default** ${{ github.head_ref }}

### `repository`

**Required** The repo to be using at
**Default** ${{ github.repository }}
