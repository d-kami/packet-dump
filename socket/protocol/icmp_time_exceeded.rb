class ICMPTimeExceeded < ICMP
    attr_reader :icmp_void

    def initialize(packet)
        super(packet)

        @icmp_void = packet.unpack('C4N')[4]
    end
end
