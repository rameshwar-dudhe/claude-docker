# Claude Code in Docker

## Build
    docker compose build

## Option A – Log in inside the container (simplest)
    docker compose run --rm claude
Claude prints a login URL. Open it in your browser, sign in, paste the code back.
Login is saved in the `claude-config` volume, so you only do this once.

## Option B – Use your existing account via token
On a machine where `claude` is installed and logged in:
    claude setup-token
Then on your machine:
    export CLAUDE_CODE_OAUTH_TOKEN=<token>
    docker compose run --rm claude

## Option C – API key
    ANTHROPIC_API_KEY=sk-ant-... docker compose run --rm claude

Note: on desktop systems, credentials may live in the OS keychain, so mounting ~/.claude
does NOT carry your login into the container — use A or B.

Your files: put them in ./workspace (mounted at /workspace).
Works on Apple Silicon and Intel (image is multi-arch via node:22-slim).

## Working on your own project folders
Mount any folder with `PROJECT_DIR`:

    PROJECT_DIR=~/Projects/myapp docker compose run --rm claude

Or add this alias to `~/.zshrc` and run `claude-d` inside any project:

    alias claude-d='docker run -it --rm -v "$PWD":/workspace -v claude-config:/home/claude/.claude claude-code:latest'

Only mounted folders are visible to Claude. For git push, mount SSH keys read-only
(`-v ~/.ssh:/home/claude/.ssh:ro`); see the commented lines in docker-compose.yml.
