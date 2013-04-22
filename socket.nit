module socket
import ffsocket



var socket = new FFSocket.socket(new FFSocketAddressFamilies.af_inet, new FFSocketTypes.sock_stream, new FFSocketProtocolFamilies.pf_null)

var hostname :FFSocket_Hostent
hostname = socket.gethostbyname("www.papercom.fr")

var addr_in = new FFSocket_Addr_In.withHostent(hostname, 30000, new FFSocketAddressFamilies.af_inet)

