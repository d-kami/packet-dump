class EtherHeader
    attr_reader :ether_dhost
    attr_reader :ether_shost
    attr_reader :ether_type

    def initialize(frame)
        @ether_dhost = mac_tos(frame, 0)
        @ether_shost = mac_tos(frame, 6)
        @ether_type = (frame[12] << 8) + frame[13]
    end

    def mac_tos(frame, index)
        return sprintf('%02X:%02X:%02X:%02X:%02X:%02X',
            frame[index], frame[index + 1], frame[index + 2], frame[index + 3], frame[index + 4], frame[index + 5])
    end
end

class Ethernet
    ETH_P_ALL    = 0x300
    ETHERTYPE_IP = 0x800
    ETHERTYPE_ARP = 0x806
end
