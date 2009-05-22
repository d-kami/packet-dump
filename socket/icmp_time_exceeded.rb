class ICMPTimeExceeded < ICMP
    attr_reader :icmp_void

    def initialize(packet)
        super(packet)
        @icmp_void = (packet[4] << 24) + (packet[5] << 16) + (packet[6] << 8) + packet[7]
    end
end
