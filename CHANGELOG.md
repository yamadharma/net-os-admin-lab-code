## [2.0.3](https://github.com/yamadharma/net-os-admin-lab-code/compare/v2.0.2...v2.0.3) (2026-09-11)

### Bug Fixes

* **makefile:** add support Ubuntu/Debian ([d4d8909](https://github.com/yamadharma/net-os-admin-lab-code/commit/d4d89099c21da74e8a631127b4921a1118fdbeed))
* **packer:** fix cleanup.sh ([d264973](https://github.com/yamadharma/net-os-admin-lab-code/commit/d264973fcd452d61c67751d4b296b41cba2cd15f))
* **packer:** fix TMPDIR in Makefile ([19061df](https://github.com/yamadharma/net-os-admin-lab-code/commit/19061df981fac57dc49a561623121fb31e135e32))
* **packer:** remove ifcfg-eth0 from kickstart ([80fba17](https://github.com/yamadharma/net-os-admin-lab-code/commit/80fba17067962f05b2ec8dc4b902c6583ac85833))
* **script:** fix add user ([9960c48](https://github.com/yamadharma/net-os-admin-lab-code/commit/9960c486926376a107bb91b9bef6a50b3b73b775))
* **script:** fix script for client routing ([c06ae96](https://github.com/yamadharma/net-os-admin-lab-code/commit/c06ae962eab7d84675609ad94330289d2c7c0eb3))
* **vagrant:** disable load libvirt plugin on Windows ([5bddde7](https://github.com/yamadharma/net-os-admin-lab-code/commit/5bddde71428deb61dc6f9f9e7cd295139e07b323))

## [2.0.2](https://github.com/yamadharma/net-os-admin-lab-code/compare/v2.0.1...v2.0.2) (2026-08-30)

### Bug Fixes

* **main:** add gitignore to subdirs ([b429478](https://github.com/yamadharma/net-os-admin-lab-code/commit/b429478d911f65469ad3ee93c7badb5eb760f364))
* **script:** switch to rocky linux 10.2 ([3416ee8](https://github.com/yamadharma/net-os-admin-lab-code/commit/3416ee8354db86edf9669486f68bd8135d7ff876))

## [2.0.1](https://github.com/yamadharma/net-os-admin-lab-code/compare/v2.0.0...v2.0.1) (2025-07-02)


### Bug Fixes

* **packer:** set port fo RDP for virtualbox ([d532945](https://github.com/yamadharma/net-os-admin-lab-code/commit/d5329453602fc79c753ad2cadc301bbfd517fd03))



# [2.0.0](https://github.com/yamadharma/net-os-admin-lab-code/compare/v1.0.2...v2.0.0) (2025-06-30)


### Bug Fixes

* **packer:** disable install virtualbox addition ([775ac8a](https://github.com/yamadharma/net-os-admin-lab-code/commit/775ac8acefc635ed04face9263b45df5fe1a6013))
* **packer:** fix install kernel headers ([016d0d1](https://github.com/yamadharma/net-os-admin-lab-code/commit/016d0d170f2ff3f7bd05b965a236bfc9fc164a20))
* **packer:** fix install virtualbox additions ([36a32d7](https://github.com/yamadharma/net-os-admin-lab-code/commit/36a32d7091415256b6e058e7f1ece14a04f6ebde))
* **packer:** switch to headless virtualbox ([48fcbb6](https://github.com/yamadharma/net-os-admin-lab-code/commit/48fcbb65b5a9fe6ae6592675f637472c7c464501))
* **vagrant:** set virtualbox headless ([f261186](https://github.com/yamadharma/net-os-admin-lab-code/commit/f261186e03d96df5b34dcf134400169a109d748d))


### Features

* **code:** move code to single directory ([25a3477](https://github.com/yamadharma/net-os-admin-lab-code/commit/25a3477eadcac63cc8fce598c55527f23f3dc865))
* **git:** add new ignored files ([ac06d15](https://github.com/yamadharma/net-os-admin-lab-code/commit/ac06d152e6d4aeb0447ef846bf47613d86f52797))
* **packer:** update to Rocky Linux 10.0 ([b8c959e](https://github.com/yamadharma/net-os-admin-lab-code/commit/b8c959eed1fb1c7acae5c53be8d6eea1c85c8b5a))



## [1.0.2](https://github.com/yamadharma/net-os-admin-lab-code/compare/v1.0.1...v1.0.2) (2024-09-26)


### Bug Fixes

* **makefile:** fix for virtualbox-7.1 ([0a58033](https://github.com/yamadharma/net-os-admin-lab-code/commit/0a58033caba77bac2efd90698a3a41cb649b24c0))



## 1.0.1 (2024-07-26)


### Bug Fixes

* **main:** remove unneeded directories ([633ea8d](https://github.com/yamadharma/net-os-admin-lab-code/commit/633ea8da1330db73e17393b7d0d8dbec09dd5bba))
* **makefile:** add halt directive ([b97021d](https://github.com/yamadharma/net-os-admin-lab-code/commit/b97021d46ff71b0132ca0d2cff27347b93fc6684))
* **makefile:** add svga type to Vagrantfile ([a2d66ba](https://github.com/yamadharma/net-os-admin-lab-code/commit/a2d66ba60218ede25b63baea37b822eb961344b5))
* **makefile:** clean makefiles ([59988a8](https://github.com/yamadharma/net-os-admin-lab-code/commit/59988a8dac5646942c42330c36d5e3159fca0d21))
* **makefile:** remove forward from vagrantfile ([a2d42a8](https://github.com/yamadharma/net-os-admin-lab-code/commit/a2d42a8273749c5fd897913bf214cb556ced7a93))
* **vagrant:** add svga type to virtualbox ([7f7ebfd](https://github.com/yamadharma/net-os-admin-lab-code/commit/7f7ebfd27a9464663e47901a62cb227394afa205))


### Features

* **main:** add license ([b4a977c](https://github.com/yamadharma/net-os-admin-lab-code/commit/b4a977c301b27db51c7085faebe3a72584bc21e6))
* **packer:** switch to RockyLinux 9.4 ([abb9cc4](https://github.com/yamadharma/net-os-admin-lab-code/commit/abb9cc4852196b34c7030017d8b2a038e7a60d3e))
* **provision:** add forward for server ([6154d5f](https://github.com/yamadharma/net-os-admin-lab-code/commit/6154d5fd8c6166967187340125a8ffcd2ad5aed6))




