class ARP
    class ARPHeader
        #ARPヘッダのreader
        attr_reader :ar_hrd
        attr_reader :ar_pro
        attr_reader :ar_hlen
        attr_reader :ar_plen
        attr_reader :ar_op

        def initialize(packet)
            @ar_hrd = (packet[0] << 8) + packet[1]
            @ar_pro = (packet[2] << 8) + packet[3]
            @ar_hlen = packet[4]
            @ar_plen = packet[5]
            @ar_op = (packet[6] << 8) + packet[7]
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

    def mac_to_s(frame, index)
        return sprintf('%02X:%02X:%02X:%02X:%02X:%02X',
            frame[index], frame[index + 1], frame[index + 2], frame[index + 3], frame[index + 4], frame[index + 5])
    end

    def ip_to_s(packet, index)
        return sprintf("%d.%d.%d.%d", packet[index], packet[index + 1], packet[index + 2], packet[index + 3])
    end
end
