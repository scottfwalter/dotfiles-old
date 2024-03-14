const completionSpec: Fig.Spec = {
  name: "+",
  description: "Fig shortcuts",
  subcommands: [
    {
      icon: "💻",
      name: "say hello",
      insertValue: "\b\becho \"hello1\"\n",
      description: "Say Hello",
    },
    {
      icon: "💻",
      name: "say hello2",
      insertValue: "\b\becho \"hello2\"\n",
      description: "Say Hello2",
    },
    {
      icon: "💻",
      name: "Jump to autocomplete repo",
      insertValue: "\b\bcd ~/.fig/projects/autocomplete\n",
      description: "Go ~/.fig/projects/autocomplete",
    },
    {
      icon: "🛠",
      name: "Start dev server",
      insertValue: "\b\bnpm run dev",
      description: "npm run dev",
    },
    {
      icon: "fig://icon?type=github",
      name: "withfig/autocomplete",
      insertValue: "\b\bopen https://github.com/withfig/autocomplete",
      description: "Open Fig Autocomplete Github page",
    },
    {
      icon: "fig://icon?type=github",
      name: "withfig/fig issues",
      insertValue: "\b\bopen https://github.com/withfig/fig/issues",
      description: "Open Fig Issues Github page",
    },
    {
      icon: "fig://icon?type=git",
      name: "Push to staging",
      insertValue: "\b\bgit push origin staging",
      description: "Push current repo to origin/staging",
    },
    {
      icon: "fig://icon?type=heroku",
      name: "View logs",
      insertValue: "\b\bheroku logs --tail",
      description: "Tail logs for current heroku app",
    },
    {
      name: "Good Morning! ☀️",
      icon: "☀️",
      description: "Update brew, NPM and node. Say an inspirational quote",
      insertValue: `
      brew update;
      npm install npm@latest -g;
      npm update -g;
      brew upgrade node;
      echo;
      npx -y fortuity | npx -y cowsay;
      echo;
      `
    },
  ],
};

export default completionSpec;