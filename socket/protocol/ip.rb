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
        header = packet.unpack('C2n3C2n')

        @version = (header[0] >> 4) & 0x0F
        @ip_hl = header[0] & 0x0F
        @ip_tos = header[1]
        @ip_len = header[2]
        @ip_id = header[3]
        @ip_off = header[4]
        @ip_ttl = header[5]
        @ip_p = header[6]
        @ip_sum = header[7]
        @ip_src = ip_to_s(packet, 12)
        @ip_dst = ip_to_s(packet, 16)
    end

    def ip_to_s(packet, index)
        address = packet[index, 4].unpack('C4')
        return sprintf("%d.%d.%d.%d", address[0], address[1], address[2], address[3])
    end
end
