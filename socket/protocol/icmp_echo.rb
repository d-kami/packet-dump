require './protocol/icmp'

class ICMPEcho < ICMP
    attr_reader :icmp_id
    attr_reader :icmp_seq

    def initialize(packet)
        super(packet)

        contents = packet.unpack('C4n2')

        @icmp_id = contents[4]
        @icmp_seq = contents[5]
    end
end
