name             'varnish'
maintainer       'Asaf Klibansky'
maintainer_email 'asaf@chicory.co'
copyright          'Chicory INC'
description      'Provisions and configures Ubuntu 16 and Varnish 4'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

supports 'ubuntu'

depends 'apt'
depends 'curl'
depends 'deploy'
depends 'opsworks'
depends 'yum'
# depends 'nodejs'
# depends 'python'
depends 'scm_helper'
depends 'supervisor'
# depends 'newrelic'
# depends 'logentries_agent'

recipe 'varnish::setup', 'Prepare base system to be used as a Varnish Cache'
recipe 'varnish::deploy', 'Deploy and configures Varnish Cache'