class ARP
    class ARPHeader
        #ARPヘッダのreader
        attr_reader :ar_hrd
        attr_reader :ar_pro
        attr_reader :ar_hlen
        attr_reader :ar_plen
        attr_reader :ar_op

        def initialize(packet)
            header = packet.unpack('n2C2n')

            @ar_hrd = header[0]
            @ar_pro = header[1]
            @ar_hlen = header[2]
            @ar_plen = header[3]
            @ar_op = header[4]
        end
    end

    #ARPヘッダと同じ値を持つ変数のreader
    attr_reader :arp_hrd
    attr_reader :arp_pro
    attr_reader :arp_hlen
    attr_reader :arp_plen
    attr_reader :arp_op

    #ARP本体のreader
    attr_reader :ea_hdr
    attr_reader :arp_sha
    attr_reader :arp_spa
    attr_reader :arp_tha
    attr_reader :arp_tpa

    def initialize(packet)
        @ea_hdr = ARPHeader.new(packet)

        @arp_hrd = @ea_hdr.ar_hrd
        @arp_pro = @ea_hdr.ar_pro
        @arp_hlen = @ea_hdr.ar_hlen
        @arp_plen = @ea_hdr.ar_plen
        @arp_op = @ea_hdr.ar_op

        @arp_sha = mac_to_s(packet, 8)
        @arp_spa = ip_to_s(packet, 14)
        @arp_tha = mac_to_s(packet, 18)
        @arp_tpa = ip_to_s(packet, 24)
    end

    def mac_to_s(packet, index)
        address = packet[index, 6].unpack('C6');

        return sprintf('%02X:%02X:%02X:%02X:%02X:%02X',
            address[0], address[1], address[2], address[3], address[4], address[5])
    end

    def ip_to_s(packet, index)
        address = packet[index, 4].unpack('C4')

        return sprintf("%d.%d.%d.%d", address[0], address[1], address[2], address[3])
    end
end
