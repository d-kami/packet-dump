class IPHeader
    attr_reader :version
    attr_reader :ip_hl
    attr_reader :ip_tos
    attr_reader :ip_len
    attr_reader :ip_id
    attr_reader :ip_off 
    attr_reader :ip_ttl
    attr_reader :ip_p
    attr_reader :ip_sum
    attr_reader :ip_src
    attr_reader :ip_dst

    def initialize(packet)
        @version = (packet[0].unpack('C')[0] >> 4) & 0x0F
        @ip_hl = packet[0].unpack('C')[0] & 0x0F
        @ip_tos = packet[1].unpack('C')[0]
        @ip_len = packet[2, 2].unpack('n')[0]
        @ip_id = packet[4, 2].unpack('n')[0]
        @ip_off = packet[6].unpack('n')[0]
        @ip_ttl = packet[8].unpack('C')[0]
        @ip_p = packet[9].unpack('C')[0]
        @ip_sum = packet[10].unpack('n')[0]
        @ip_src = ip_to_s(packet, 12)
        @ip_dst = ip_to_s(packet, 16)
    end

    def ip_to_s(packet, index)
        address = packet[index, 4].unpack('C4')
        return sprintf("%d.%d.%d.%d", address[0], address[1], address[2], address[3])
    end
end
