# Changelog

## [0.4.2](https://github.com/dev-sec/cis-dil-benchmark/tree/0.4.2) (2020-07-23)

[Full Changelog](https://github.com/dev-sec/cis-dil-benchmark/compare/0.4.1...0.4.2)

**Merged pull requests:**

- The release draft references the correct SHA [\#82](https://github.com/dev-sec/cis-dil-benchmark/pull/82) ([micheelengronne](https://github.com/micheelengronne))

## [0.4.1](https://github.com/dev-sec/cis-dil-benchmark/tree/0.4.1) (2020-05-19)

[Full Changelog](https://github.com/dev-sec/cis-dil-benchmark/compare/0.4.0...0.4.1)

**Merged pull requests:**

- align versions [\#80](https://github.com/dev-sec/cis-dil-benchmark/pull/80) ([micheelengronne](https://github.com/micheelengronne))

## [0.4.0](https://github.com/dev-sec/cis-dil-benchmark/tree/0.4.0) (2020-05-19)

[Full Changelog](https://github.com/dev-sec/cis-dil-benchmark/compare/0.3.0...0.4.0)

**Closed issues:**

- dil-benchmark-1.6.2.2: undefined method `positive?' for \#\<RSpec::Matchers::DSL::Matcher cmp\> [\#72](https://github.com/dev-sec/cis-dil-benchmark/issues/72)
- WARN: DEPRECATION: The 'default' option for attributes is being replaced by 'value' - please use it instead. attribute name: 'Inspec::Input' [\#69](https://github.com/dev-sec/cis-dil-benchmark/issues/69)

**Merged pull requests:**

- automated release [\#79](https://github.com/dev-sec/cis-dil-benchmark/pull/79) ([micheelengronne](https://github.com/micheelengronne))
- Support wild configs that are tabbed out [\#78](https://github.com/dev-sec/cis-dil-benchmark/pull/78) ([markdchurchill](https://github.com/markdchurchill))
- SSH config: Allow seconds & minutes config for grace time [\#77](https://github.com/dev-sec/cis-dil-benchmark/pull/77) ([markdchurchill](https://github.com/markdchurchill))
- Refactor out grub config to profile file [\#76](https://github.com/dev-sec/cis-dil-benchmark/pull/76) ([markdchurchill](https://github.com/markdchurchill))
- iptables: support conntrack module [\#75](https://github.com/dev-sec/cis-dil-benchmark/pull/75) ([markdchurchill](https://github.com/markdchurchill))
- Update 3.3 IPv6 to support Amazon Linux 2 [\#74](https://github.com/dev-sec/cis-dil-benchmark/pull/74) ([markdchurchill](https://github.com/markdchurchill))
- reverse rubocop updates to support ruby versions bundled with InSpec 3 [\#73](https://github.com/dev-sec/cis-dil-benchmark/pull/73) ([chris-rock](https://github.com/chris-rock))
- pin to inspec 3 [\#71](https://github.com/dev-sec/cis-dil-benchmark/pull/71) ([chris-rock](https://github.com/chris-rock))
- Inspec 4 warning [\#70](https://github.com/dev-sec/cis-dil-benchmark/pull/70) ([micheelengronne](https://github.com/micheelengronne))

## [0.3.0](https://github.com/dev-sec/cis-dil-benchmark/tree/0.3.0) (2019-02-04)

[Full Changelog](https://github.com/dev-sec/cis-dil-benchmark/compare/0.2.0...0.3.0)

**Closed issues:**

- Make a release [\#64](https://github.com/dev-sec/cis-dil-benchmark/issues/64)
- Tagging versions for release? [\#51](https://github.com/dev-sec/cis-dil-benchmark/issues/51)
- Why are you using custom linux\_module instead of the Inspec built in kernel\_module? [\#48](https://github.com/dev-sec/cis-dil-benchmark/issues/48)
- How much divergence from CIS DIL Benchmark document is accepted? [\#43](https://github.com/dev-sec/cis-dil-benchmark/issues/43)

**Merged pull requests:**

- 0.3.0 [\#65](https://github.com/dev-sec/cis-dil-benchmark/pull/65) ([chris-rock](https://github.com/chris-rock))
- Ensure /etc/group- /etc/shadow- and /etc/gshadow- match their respect… [\#63](https://github.com/dev-sec/cis-dil-benchmark/pull/63) ([bdwyertech](https://github.com/bdwyertech))
- Fixes [\#62](https://github.com/dev-sec/cis-dil-benchmark/pull/62) ([bdwyertech](https://github.com/bdwyertech))
- Change `password` to `passwords` [\#60](https://github.com/dev-sec/cis-dil-benchmark/pull/60) ([jerryaldrichiii](https://github.com/jerryaldrichiii))
- Update issue templates [\#56](https://github.com/dev-sec/cis-dil-benchmark/pull/56) ([rndmh3ro](https://github.com/rndmh3ro))
- use inspec's new unified attributes feature [\#55](https://github.com/dev-sec/cis-dil-benchmark/pull/55) ([chris-rock](https://github.com/chris-rock))
- modify package check to satisfy openjdk dependency [\#53](https://github.com/dev-sec/cis-dil-benchmark/pull/53) ([alval5280](https://github.com/alval5280))
- allow group write /var/log/wtmp [\#50](https://github.com/dev-sec/cis-dil-benchmark/pull/50) ([alval5280](https://github.com/alval5280))

## [0.2.0](https://github.com/dev-sec/cis-dil-benchmark/tree/0.2.0) (2018-08-26)

[Full Changelog](https://github.com/dev-sec/cis-dil-benchmark/compare/0.1.0...0.2.0)

**Closed issues:**

- Debian uses group 42 \('shadow'\) as group for shadow files [\#31](https://github.com/dev-sec/cis-dil-benchmark/issues/31)
- inspec fails to run due to undefined method 'passwords' [\#5](https://github.com/dev-sec/cis-dil-benchmark/issues/5)
- Wrong modinfo option [\#4](https://github.com/dev-sec/cis-dil-benchmark/issues/4)
- Getting undefined method `split' for nil:NilClass \(NoMethodError\) on MacOS [\#3](https://github.com/dev-sec/cis-dil-benchmark/issues/3)
- Update 6\_2\_user\_and\_group\_settings.rb to mock empty array. [\#1](https://github.com/dev-sec/cis-dil-benchmark/issues/1)

**Merged pull requests:**

- 0.2.0 [\#52](https://github.com/dev-sec/cis-dil-benchmark/pull/52) ([chris-rock](https://github.com/chris-rock))
- Modified controls to use the built in kernel\_module of Inspec [\#49](https://github.com/dev-sec/cis-dil-benchmark/pull/49) ([itoperatorguy](https://github.com/itoperatorguy))
- handle potential leading space for umask regex [\#47](https://github.com/dev-sec/cis-dil-benchmark/pull/47) ([veetow](https://github.com/veetow))
- increase rubocop block length [\#44](https://github.com/dev-sec/cis-dil-benchmark/pull/44) ([chris-rock](https://github.com/chris-rock))
- Fix shadow user and password deprecations [\#42](https://github.com/dev-sec/cis-dil-benchmark/pull/42) ([timstoop](https://github.com/timstoop))
- Fix a compare with zero. [\#41](https://github.com/dev-sec/cis-dil-benchmark/pull/41) ([timstoop](https://github.com/timstoop))
- Also allow pool to be set. [\#39](https://github.com/dev-sec/cis-dil-benchmark/pull/39) ([timstoop](https://github.com/timstoop))
- Make the 4.1.15 check less strict. [\#38](https://github.com/dev-sec/cis-dil-benchmark/pull/38) ([timstoop](https://github.com/timstoop))
- According to CIS DIL 1.1.0, wtmp and btmp should be tagged logins. [\#37](https://github.com/dev-sec/cis-dil-benchmark/pull/37) ([timstoop](https://github.com/timstoop))
- This fixes for the syntax for CIS DIL 4.1.6 to require just one valid describe. [\#36](https://github.com/dev-sec/cis-dil-benchmark/pull/36) ([timstoop](https://github.com/timstoop))
- Make the check slightly less strict. [\#35](https://github.com/dev-sec/cis-dil-benchmark/pull/35) ([timstoop](https://github.com/timstoop))
- Fix deprecation warnings. [\#34](https://github.com/dev-sec/cis-dil-benchmark/pull/34) ([timstoop](https://github.com/timstoop))
- Debian uses group 42 shadow [\#33](https://github.com/dev-sec/cis-dil-benchmark/pull/33) ([timstoop](https://github.com/timstoop))
- updated regex to account for sha512 not being first option [\#30](https://github.com/dev-sec/cis-dil-benchmark/pull/30) ([crashdummymch](https://github.com/crashdummymch))
- Adjust modprobe check to remove false positives. [\#28](https://github.com/dev-sec/cis-dil-benchmark/pull/28) ([millerthomasj](https://github.com/millerthomasj))
- Update umask checks for Centos7 and Amazon Linux. [\#27](https://github.com/dev-sec/cis-dil-benchmark/pull/27) ([millerthomasj](https://github.com/millerthomasj))
- Update password quality checks for pam. [\#25](https://github.com/dev-sec/cis-dil-benchmark/pull/25) ([millerthomasj](https://github.com/millerthomasj))
- Allowed MACs should allow for greater security [\#24](https://github.com/dev-sec/cis-dil-benchmark/pull/24) ([millerthomasj](https://github.com/millerthomasj))
- pin inspec 2.1.0 [\#23](https://github.com/dev-sec/cis-dil-benchmark/pull/23) ([chris-rock](https://github.com/chris-rock))
- Should check one of cron or crond not both. [\#22](https://github.com/dev-sec/cis-dil-benchmark/pull/22) ([millerthomasj](https://github.com/millerthomasj))
- Add auditd fixes for Centos7 [\#21](https://github.com/dev-sec/cis-dil-benchmark/pull/21) ([millerthomasj](https://github.com/millerthomasj))
- Add tcp\_wrappers package for both Centos7 and Amazon Linux. [\#20](https://github.com/dev-sec/cis-dil-benchmark/pull/20) ([millerthomasj](https://github.com/millerthomasj))
- Add additional filepath for chrony.conf on Centos7. [\#19](https://github.com/dev-sec/cis-dil-benchmark/pull/19) ([millerthomasj](https://github.com/millerthomasj))
- Ntpd run as user [\#18](https://github.com/dev-sec/cis-dil-benchmark/pull/18) ([millerthomasj](https://github.com/millerthomasj))
- Centos7 uses grub2 by default, add checks for proper file. [\#17](https://github.com/dev-sec/cis-dil-benchmark/pull/17) ([millerthomasj](https://github.com/millerthomasj))
- On both Centos7 and latest Amazon Linux ansible auto creates cron ent… [\#16](https://github.com/dev-sec/cis-dil-benchmark/pull/16) ([millerthomasj](https://github.com/millerthomasj))
- updated regex to detect proper string [\#15](https://github.com/dev-sec/cis-dil-benchmark/pull/15) ([crashdummymch](https://github.com/crashdummymch))
- Undefinedmethod [\#14](https://github.com/dev-sec/cis-dil-benchmark/pull/14) ([crashdummymch](https://github.com/crashdummymch))
- changed command for redhat family to modprobe to properly evaluate test [\#10](https://github.com/dev-sec/cis-dil-benchmark/pull/10) ([crashdummymch](https://github.com/crashdummymch))
- implements inspec check and enables it in travis [\#9](https://github.com/dev-sec/cis-dil-benchmark/pull/9) ([chris-rock](https://github.com/chris-rock))
- use inspec's os\_env split method [\#8](https://github.com/dev-sec/cis-dil-benchmark/pull/8) ([chris-rock](https://github.com/chris-rock))
- Passwords to password [\#6](https://github.com/dev-sec/cis-dil-benchmark/pull/6) ([crashdummymch](https://github.com/crashdummymch))

## [0.1.0](https://github.com/dev-sec/cis-dil-benchmark/tree/0.1.0) (2017-08-15)

[Full Changelog](https://github.com/dev-sec/cis-dil-benchmark/compare/7aa8ff2433d0f01591fedd2633af3883cfc81033...0.1.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
