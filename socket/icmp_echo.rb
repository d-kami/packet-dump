class ICMPEcho < ICMP
    attr_reader :icmp_id
    attr_reader :icmp_seq

    def initialize(packet)
        super(packet)
        @icmp_id = (packet[4] << 8) + packet[5]
        @icmp_seq = (packet[6] << 8) + packet[7]
    end
end