workflow "Release" {
  on = "release"
  resolves = ["Write GitHub Release", "Publish Gem"]
}

action "Write GitHub Release" {
  uses = "./.github/action/write_github_release"
  secrets = ["GITHUB_TOKEN"]
}

action "Publish Gem" {
  uses = "./.github/action/publish_gem"
  secrets = ["GITHUB_TOKEN", "RUBYGEMS_TOKEN"]
}
