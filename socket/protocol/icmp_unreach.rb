class ICMPUnreach < ICMP
    attr_reader :icmp_pmvoid
    attr_reader :icmp_nextmtu

    def initialize(packet)
        super(packet)

        contents = packet.unpack('C4n2')

        @icmp_pmvoid = contents[4]
        @icmp_nextmtu = contents[5]
    end
end
