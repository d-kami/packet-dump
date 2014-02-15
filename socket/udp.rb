class UDPHeader
    attr_reader :uh_sport
    attr_reader :uh_dport
    attr_reader :uh_ulen
    attr_reader :us_sum

    def initialize(packet)
        @uh_sport = packet[0, 2].unpack('n')[0]
        @uh_dport = packet[2, 2].unpack('n')[0]
        @uh_ulen = packet[4, 2].unpack('n')[0]
        @uh_sum = packet[6, 2].unpack('n')[0]
    end
end
