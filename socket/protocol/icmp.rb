class ICMP
    attr_reader :icmp_type
    attr_reader :icmp_code
    attr_reader :icmp_cksum

    ICMP_ECHOREPLY    = 0
    ICMP_UNREACH      = 3
    ICMP_SOURCEQUENCH = 4
    ICMP_REDIRECT     = 5
    ICMP_ECHO         = 8
    ICMP_TIMXCEED     = 11
    ICMP_PARAMPROB    = 12

    def initialize(packet)
        header = packet.unpack('C2n')

        @icmp_type = header[0]
        @icmp_code = header[1]
        @icmp_cksum = header[2]
    end
end
