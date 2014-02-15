require './icmp'
require './icmp_echo'
require './icmp_unreach'
require './icmp_redirect'
require './icmp_time_exceeded'

class ICMPParser
    def ICMPParser::parse(packet)
        if(packet[0] == ICMP::ICMP_ECHOREPLY || packet[0] == ICMP::ICMP_ECHO)
            return ICMPEcho.new(packet)
        elsif(packet[0] == ICMP::ICMP_UNREACH)
            return ICMPUnreach.new(packet)
        elsif(packet[0] == ICMP::ICMP_REDIRECT)
            return ICMPRedirect.new(packet)
        elsif(packet[0] == ICMP::ICMP_TIMXCEED)
            return ICMPTimeExceeded.new(packet)
        else
            return ICMP.new(packet)
        end
    end
end
