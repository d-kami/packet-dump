require './protocol/icmp'
require './protocol/icmp_echo'
require './protocol/icmp_unreach'
require './protocol/icmp_redirect'
require './protocol/icmp_time_exceeded'

class ICMPParser
    def ICMPParser::parse(packet)
        type = packet.unpack('C')[0]

        case type
        when ICMP::ICMP_ECHOREPLY, ICMP::ICMP_ECHO then
            return ICMPEcho.new(packet)
        when ICMP::ICMP_UNREACH then
            return ICMPUnreach.new(packet)
        when ICMP::ICMP_REDIRECT then
            return ICMPRedirect.new(packet)
        when ICMP::ICMP_TIMXCEED then
            return ICMPTimeExceeded.new(packet)
        else
            return ICMP.new(packet)
        end
    end
end
