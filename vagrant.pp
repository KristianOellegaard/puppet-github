node default {
	package {
		"ruby-json":
			ensure => 'installed',
	}
	
	class {
		"puppet-github::config":
			username => "GithubUsername",
			password => "your github password",
			repository => "GithubUsername/puppet-config",
	}
	file {
		"/some/unexisting/path":
			content => '',
	}
}