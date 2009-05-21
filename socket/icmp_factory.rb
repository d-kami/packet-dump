require 'icmp'
require 'icmp_echo'

class ICMPFactory
    def ICMPFactory::parse(packet)
        if(packet[0] == ICMP::ICMP_ECHOREPLY || packet[0] == ICMP::ICMP_ECHO)
            return ICMPEcho.new(packet)
        end
    end
end
