class ICMPUnreach < ICMP
    attr_reader :icmp_pmvoid
    attr_reader :icmp_nextmtu

    def initialize(packet)
        super(packet)
        @icmp_pmvoid = (packet[4] << 8) + packet[5]
        @icmp_nextmtu = (packet[6] << 8) + packet[7]
    end
end
