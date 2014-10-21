name             'gitlab-omni'
maintainer       'Bigpoint GmbH'
maintainer_email 'sebgrewe@bigpoint.net'
license          'Apache 2.0'
description      'Installs and configures a default Gitlab instance using their Omnibus Package'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.3.1'

supports 'debian', '>= 7.0'
supports 'centos', '>= 6.5'

depends 'logrotate', '>= 1.6.0'
