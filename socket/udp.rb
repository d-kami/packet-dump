class UDPHeader
    attr_reader :uh_sport
    attr_reader :uh_dport
    attr_reader :uh_ulen
    attr_reader :us_sum

    def initialize(packet)
        @uh_sport = (packet[0] << 8) + packet[1]
        @uh_dport = (packet[2] << 8) + packet[3]
        @uh_ulen = (packet[4] << 8) + packet[5]
        @uh_sum = (packet[6] << 8) + packet[7]
    end
end
