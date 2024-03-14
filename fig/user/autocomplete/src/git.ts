const completionSpec: Fig.Spec = {
  name: "git",
  additionalSuggestions: [
    {
      name: "commit -m 'msg'",
      insertValue: "commit -m '{cursor}'",
      description: "Git commit shortcut",
    },
    {
      name: "stash, pull, pop",
      description: "Git stash, pull, and pip shortcut",
      insertValue: "stash; git pull; git stash pop",
      type: "shortcut"
    },
    {
      name: "add, commit, & push",
      description: "Git add, commit, and push shortcut",
      insertValue: "commit -a --allow-empty-message -m ''; git push;",
      type: "shortcut"
    },
    {
      name: "undo most recent commit",
      description: "Git commit shortcut",
      insertValue: "reset --soft HEAD~1",
      type: "shortcut"
    },
    {
      name: "log (pretty print)",
      insertValue: "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all",
      description: "Pretty print git log",
    },
    {
      name: "log (pretty print really)",
      insertValue: "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all",
      description: "Pretty print git log",
    },
  ],
  subcommands: [
    {
      name: "push",
      additionalSuggestions: [
        {
          name: "origin/main",
          insertValue: "origin main",
          description: "Git push origin main",
        }
      ]
    },
    {
      name: "commit",
      options: [
        {
          name: "-m",
          args: {
            suggestions: [{
              name: "feat: ",
              insertValue: "'feat: {cursor}'"
            },
            {
              name: "fix: ",
              insertValue: "'fix: {cursor}'"
            }]
          }
        }
      ]
    }
  ]
}

export default completionSpec;