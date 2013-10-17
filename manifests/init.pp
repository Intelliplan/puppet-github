class github {
  package { ['curl','tar']: }
}

define github::tarball (
  $extract_to = undef,
  $repo       = $title,
  $ref        = 'master',
  $creates    = undef,
) {
  require github

  if $extract_to == undef { fail('extract_to is required') }
  if $repo == undef { fail('repo is required') }
  if $ref == undef { fail('ref is required') }
  
  $github_url = "https://github.com/${repo}/archive/${ref}.tar.gz"
  exec { "${title}::download_and_extract":
    command => "curl -sSL \"${github_url}\" | tar -C \"${extract_to}\" --strip-components=1 --no-same-owner -xzf -",
    path    => ['/usr/local/bin', '/bin', '/usr/bin'],
    require => Exec["${title}::ensure::path"],
    creates => $creates,
  }
}
