class ICMPRedirect < ICMP
    attr_reader :icmp_gwaddr

    def initialize(packet) 
        super(packet)
        @icmp_gwaddr = ip_to_s(packet.unpack('C8'), 4)
    end

    def ip_to_s(packet, index)
        return sprintf("%d.%d.%d.%d", packet[index], packet[index + 1], packet[index + 2], packet[index + 3])
    end
end
