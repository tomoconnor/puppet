class applications::truecrypt{
	package {"truecrypt-wrapper":
		ensure => latest,
	}
	package {"truecrypt7.1":
		ensure => latest,
	}

	Package['truecrypt-wrapper'] -> Package['truecrypt7.1']
}
