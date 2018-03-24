class UDPHeader
    attr_reader :uh_sport
    attr_reader :uh_dport
    attr_reader :uh_ulen
    attr_reader :us_sum

    def initialize(packet)
        header = packet.unpack('n4')

        @uh_sport = header[0]
        @uh_dport = header[1]
        @uh_ulen = header[2]
        @uh_sum = header[3]
    end
end
