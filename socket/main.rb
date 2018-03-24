require 'socket'

require './protocol/ether'
require './protocol/ip'
require './protocol/arp'
require './protocol/tcp'
require './protocol/udp'
require './protocol/icmp_parser'

socket = Socket.open(Socket::AF_INET, Socket::SOCK_PACKET, Ethernet::ETH_P_ALL)

loop do
    buff, sockaddr = socket.recvfrom(8192)

    ether_header = EtherHeader.new(buff)

    puts 'Ethernet Frame'
    puts "src Mac Address #{ether_header.ether_shost}"
    puts "dst Mac Address #{ether_header.ether_dhost}"
    puts sprintf("EtherType = 0x%X", ether_header.ether_type)

    buff.slice!(0..13)

    if(ether_header.ether_type == Ethernet::ETHERTYPE_IP)
        puts 'IP Header'
        ip_header = IPHeader.new(buff)
        puts "src IP Address #{ip_header.ip_src}"
        puts "dst IP Address #{ip_header.ip_dst}"
        puts "Protocol #{ip_header.ip_p}"
        puts "Length #{ip_header.ip_len}"
        buff.slice!(0..(ip_header.ip_hl << 2) - 1)

        transport_size = 0

        if(ip_header.ip_p == Socket::IPPROTO_TCP)
            puts 'TCP Headaer'
            tcp_header = TCPHeader.new(buff)
            puts "src Port #{tcp_header.th_sport}"
            puts "dst Port #{tcp_header.th_dport}"
            transport_size = tcp_header.th_off << 2
            buff.slice!(0..transport_size - 1)

            size = ip_header.ip_len - (ip_header.ip_hl << 2) - transport_size - 1
            if(tcp_header.th_dport == 80 && size > 0)
                contents = buff.slice(0..size)
                puts contents
            end
        elsif(ip_header.ip_p == Socket::IPPROTO_UDP)
            puts 'UDP Header'
            udp_header = UDPHeader.new(buff)
            puts "src Port #{udp_header.uh_sport}"
            puts "dst Port #{udp_header.uh_dport}"
            transport_size = udp_header.uh_ulen
            buff.slice!(0..transport_size - 1)
        elsif(ip_header.ip_p == Socket::IPPROTO_ICMP)
            puts 'ICMP Header'
            icmp = ICMPParser.parse(buff)
            puts "icmp_type = #{icmp.icmp_type}"

            case icmp.icmp_type
            when ICMP::ICMP_ECHOREPLY then
                puts 'Echo Reply'
            when ICMP::ICMP_UNREACH then
                puts 'Unreach'
            when ICMP::ICMP_SOURCEQUENCH then
                puts 'SourceEquench'
            when ICMP::ICMP_REDIRECT then
                puts 'Redirect'
            when ICMP::ICMP_ECHO then
                puts 'Echo'
            when ICMP::ICMP_TIMXCEED then
                puts 'TimeExceed'
            when ICMP::ICMP_PARAMPROB then
                puts 'Error'
            end
        end
    elsif(ether_header.ether_type == Ethernet::ETHERTYPE_ARP)
        puts 'ARP Header'
        arp = ARP.new(buff)

        puts "src MAC Address #{arp.arp_sha}"
        puts "src IP Address #{arp.arp_spa}"
        puts "dst MAC Address #{arp.arp_tha}"
        puts "dst IP Address #{arp.arp_tpa}"
    end

    puts
end
