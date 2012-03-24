class puppet-github::config($username, $password, $repository) {
	file {
		"/etc/puppet/github.yaml":
			content => "---
:github_user: '$username'
:github_pass: '$password'
:github_repo: '$repository'",
	}
}