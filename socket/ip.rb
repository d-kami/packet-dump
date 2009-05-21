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
        @version = (packet[0] >> 4) & 0x0F
        @ip_hl = packet[0] & 0x0F
        @ip_tos = packet[1]
        @ip_len = (packet[2] << 8) + packet[3]
        @ip_id = (packet[4] << 8) + packet[5]
        @ip_off = (packet[6] << 8) + packet[7]
        @ip_ttl = packet[8]
        @ip_p = packet[9]
        @ip_sum = (packet[10] << 8) + packet[11]
        @ip_src = ip_to_s(packet, 12)
        @ip_dst = ip_to_s(packet, 16)
    end

    def ip_to_s(packet, index)
        return sprintf("%d.%d.%d.%d", packet[index], packet[index + 1], packet[index + 2], packet[index + 3])
    end
end
