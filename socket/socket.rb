require 'socket'
require './ether'
require './ip'
require './arp'
require './tcp'
require './udp'
require './icmp_factory'

socket = Socket.open(Socket::AF_INET, Socket::SOCK_PACKET, Ethernet::ETH_P_ALL)

loop do
    buff, sockaddr = socket.recvfrom(8192)

    ether_header = EtherHeader.new(buff)

    puts 'Ethernetフレーム'
    puts "送信元MACアドレス #{ether_header.ether_shost}"
    puts "送信先MACアドレス #{ether_header.ether_dhost}"
    puts sprintf("EtherType = 0x%X", ether_header.ether_type)

    buff.slice!(0..13)

    if(ether_header.ether_type == Ethernet::ETHERTYPE_IP)
        puts 'IPパケット'
        ip_header = IPHeader.new(buff)
        puts "送信元IPアドレス #{ip_header.ip_src}"
        puts "送信先IPアドレス #{ip_header.ip_dst}"
        puts "プロトコル番号 #{ip_header.ip_p}"
        puts "サイズ #{ip_header.ip_len}"
        buff.slice!(0..(ip_header.ip_hl << 2) - 1)

        transport_size = 0

        if(ip_header.ip_p == Socket::IPPROTO_TCP)
            puts 'TCPパケット'
            tcp_header = TCPHeader.new(buff)
            puts "送信元ポート番号 #{tcp_header.th_sport}"
            puts "送信先ポート番号 #{tcp_header.th_dport}"
            transport_size = tcp_header.th_off << 2
            buff.slice!(0..transport_size - 1)

            size = ip_header.ip_len - (ip_header.ip_hl << 2) - transport_size - 1
            if(tcp_header.th_dport == 80 && size > 0)
                contents = buff.slice(0..size)
                puts contents
            end
        elsif(ip_header.ip_p == Socket::IPPROTO_UDP)
            puts 'UDPパケット'
            udp_header = UDPHeader.new(buff)
            puts "送信元ポート番号 #{udp_header.uh_sport}"
            puts "送信先ポート番号 #{udp_header.uh_dport}"
            transport_size = udp_header.uh_ulen
            buff.slice!(0..transport_size - 1)
        elsif(ip_header.ip_p == Socket::IPPROTO_ICMP)
            puts 'ICMPパケット'
            icmp = ICMPFactory.parse(buff)
            puts icmp.icmp_type
        end
    elsif(ether_header.ether_type == Ethernet::ETHERTYPE_ARP)
        puts 'ARPパケット'
        arp = ARP.new(buff)

        puts "送信元MACアドレス #{arp.arp_sha}"
        puts "送信元IPアドレス #{arp.arp_spa}"
        puts "送信先MACアドレス #{arp.arp_tha}"
        puts "送信先IPアドレス #{arp.arp_tpa}"
    end

    puts
end
