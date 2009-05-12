class TCPHeader
    attr_reader :th_sport
    attr_reader :th_dport
    attr_reader :th_seq
    attr_reader :th_ack
    attr_reader :th_off
    attr_reader :th_x2
    attr_reader :th_falgs
    attr_reader :th_win
    attr_reader :th_sum
    attr_reader :th_urp

    def initialize(packet)
        @th_sport = (packet[0] << 8) + packet[1]
        @th_dport = (packet[2] << 8) + packet[3]
        @th_seq = (packet[4] << 24) + (packet[5] << 16) + (packet[6] << 8) + packet[7]
        @th_ack = (packet[8] << 24) + (packet[9] << 16) + (packet[10] << 8) + packet[11]
        @th_off = (packet[12] >> 4) & 0x0F
        @th_x2 = packet[12] & 0x0F
        @th_flags = packet[13]
        @th_win = (packet[14] << 8) + packet[15]
        @th_sum = (packet[16] << 8) + packet[17]
        @th_urp = (packet[18] << 8) + packet[19]
    end
end
