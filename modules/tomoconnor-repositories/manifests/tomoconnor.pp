class repositories::tomoconnor {
	apt::source {"tomoconnor_${lsbdistcodename}_stable":
		location => "http://apt/tomoconnor-${lsbdistcodename}",
		release => "tomoconnor-${lsbdistcodename}",
		repos => "stable",
	}
}

class repositories::tomoconnor::unstable {
	apt::source {"tomoconnor_${lsbdistcodename}_unstable":
		location => "http://apt/tomoconnor-${lsbdistcodename}",
		release => "tomoconnor-${lsbdistcodename}",
		repos => "unstable",
	}
}
