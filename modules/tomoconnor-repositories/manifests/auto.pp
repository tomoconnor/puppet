class repositories::auto::stable {
        apt::source {"auto_${lsbdistcodename}_stable":
                location => "http://apt/auto-${lsbdistcodename}",
                release => "auto-${lsbdistcodename}",
                repos => "stable",
        }

}

class repositories::auto::unstable {
        apt::source {"auto_${lsbdistcodename}_unstable":
                location => "http://apt/auto-${lsbdistcodename}",
                release => "auto-${lsbdistcodename}",
                repos => "unstable",
        }
}

