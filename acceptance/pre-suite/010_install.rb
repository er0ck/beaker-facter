require 'acceptance/install'
extend Acceptance::Install

step 'Install facter' do
  sha = ENV['SHA'] || ENV['GIT_SHA'] || 'nightly'
  hosts.each do |host|
    install_repos_on(host, 'puppet-agent', sha, 'repo-configs')
    host.add_env_var('PATH', '/opt/puppetlabs/bin:${PATH}')
  end

  PACKAGES = {
    :redhat => [
      'puppet-agent',
    ],
    :debian => [
      'puppet-agent',
    ],
  }

  install_packages_on(hosts, PACKAGES)
end
