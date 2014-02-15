class EtherHeader
    attr_reader :ether_dhost
    attr_reader :ether_shost
    attr_reader :ether_type

    def initialize(frame)
        @ether_dhost = mac_to_s(frame, 0)
        @ether_shost = mac_to_s(frame, 6)
        @ether_type = frame[12, 2].unpack('n')[0]
    end

    def mac_to_s(frame, index)
        header = frame[index, 6].unpack('C*');

        return sprintf('%02X:%02X:%02X:%02X:%02X:%02X',
            header[0], header[1], header[2], header[3], header[4], header[5])
    end
end

class Ethernet
    ETH_P_ALL    = 0x300
    ETHERTYPE_IP = 0x800
    ETHERTYPE_ARP = 0x806
end
