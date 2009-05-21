class ICMP
    attr_reader :icmp_type
    attr_reader :icmp_code
    attr_reader :icmp_cksum

    ICMP_ECHOREPLY = 0
    ICMP_ECHO = 8

    def initialize(packet)
        @icmp_type = packet[0]
        @icmp_code = packet[1]
        @icmp_cksum = (packet[2] << 8) + packet[3]
    end
end
