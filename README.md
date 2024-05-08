# dotfiles

Contains everything needed to get a good environment set up for Macos.

## Instructions
1. Clone this repo anywhere
2. Run `chmod +x ./setup.sh && ./setup.sh`
3. Add the below to `~/.zshrc`
4. Run `source ~/.zshrc`

Add to ~/.zshrc:
```bash
PROJ_DIR="<path to where project groups/gh-accounts are stored>"
PROJ_ACCOUNT="<default account>"
```

## Usage
Open in neovim
```bash
nv path/to/file/or/dir
```


Open a project in neovim
```bash
dev gh_account/project_name
```


Open a project from your `PROJ_ACCOUNT` account
```bash
dev project_name
```
