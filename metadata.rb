name             'raxio'
maintainer       'Dimitry Ushakov'
maintainer_email 'dimitry.ushakov@rackspace.com'
license          'Apache 2.0'
description      'Installs and configures prereqs for 2015 talk'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.2'

depends 'jenkins',   '~> 2.0'
depends 'maven'
depends 'sonar'
