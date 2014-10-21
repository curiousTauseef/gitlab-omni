Gitab Cookbook
=========================

This cookbook will setup a Gitlab instance. It will use the Gitlab
Omnibus package for installation.

Requirements
------------

# Cookbooks

* none

Attributes
----------

Please see the supplied attributes file for common defaults and how to
change them. Other attributes not listed can be found on the official
omnibus package (e.g. how to write `the gitlab.rb` file).

Usage
-----

Add `recipe[gitlab]` in your nodes run list.

Data Bag
========

* `gitlab`

This container holds all information to setup a new instance.

* `ldap`

The ldap item holds optional LDAP server information, see supplied
encrypted data bag using knife solo data bag for details.

* `certificate`

The certificate item holds an optional SSL certificate which will be
installed in Nginx. If you set your `external_url` to https, ensure you
have a data bag ready holding your certificate. See supplied encrypted
data bag using knife solo data bag for details.

Data Bag Location
-----------------

* `test/integration/data_bags` for Kitchen

Data Bag Format
---------------

* Use `knife solo data bag` to create and edit local data bags

## License & Authors
- Author:: Sebastian Grewe <sebgrewe@bigpoint.net>

```text
Copyright:: 2014 Bigpoint GmbH

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

