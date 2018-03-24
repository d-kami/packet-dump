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
        header = packet.unpack('n2N2nC2n3')

        @th_sport = header[0]
        @th_dport = header[1]
        @th_seq = header[2]
        @th_ack = header[3]
        @th_off = (header[4] >> 4) & 0x0F
        @th_x2 = header[4] & 0x0F
        @th_flags = header[5]
        @th_win = header[6]
        @th_sum = header[7]
        @th_urp = header[8]
    end
end
