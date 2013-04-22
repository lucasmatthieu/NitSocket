module ffsocket

in "C Header" `{
	#include <stdio.h>
	#include <stdlib.h>
	#include <unistd.h>
	#include <string.h>
	#include <sys/socket.h>
	#include <sys/types.h>
	#include <netinet/in.h>
	#include <arpa/inet.h>
	#include <netdb.h>
	
	#include "../socketerrors.h"
	typedef int FFSocketDescriptor;
`}

extern FFSocket_Hostent `{ struct hostent * `}
	private fun i_h_aliases(i:Int):String `{ return new_String_from_cstring(recv->h_aliases[i]); `}
	private fun i_h_aliases_reachable(i:Int):Bool `{ return (recv->h_aliases[i] != NULL); `}
	fun h_aliases:Array[String]
	do
		var i=0
		var d=new Array[String]
		loop
			d.add(i_h_aliases(i))
			if i_h_aliases_reachable(i+1) == false then break
			i += 1
		end
		return d
	end
	fun h_addr:String `{ 
		char * f = inet_ntoa(*(struct in_addr*)recv->h_addr);
		return new_String_from_cstring(f); 
	`}
	fun h_addrtype:Int `{ return recv->h_addrtype; `}
	fun h_length:Int `{ return recv->h_length; `}
	fun h_name:String `{ return new_String_from_cstring(recv->h_name); `}
end
extern FFSocket_Addr_In `{ struct sockaddr_in `}
	new withHostent(hostent: FFSocket_Hostent, port: Int, family: FFSocketAddressFamilies) `{
		struct sockaddr_in sai = {0};
		sai.sin_family = hostent->h_addrtype;
		sai.sin_len = hostent->h_length;
		sai.sin_port = htons(port);
		memcpy( (char*)&sai.sin_addr.s_addr, (char*)hostent->h_addr, hostent->h_length );
		return sai;
	`}
	fun address:String `{ 
		char *f = inet_ntoa(recv.sin_addr);
		return new_String_from_cstring(f); 
	`}
	fun family:FFSocketAddressFamilies `{ return recv.sin_family; `}
	fun port:Int `{ return ntohs(recv.sin_port); `}
	fun length:Int `{ return recv.sin_len; `}	
end
extern FFSocketTypes `{ int `}
	new sock_stream `{ return SOCK_STREAM; `}
	new sock_dgram `{ return SOCK_DGRAM; `}
	new sock_raw `{ return SOCK_RAW; `}
	new sock_seqpacket `{ return SOCK_SEQPACKET; `}
end
extern FFSocketAddressFamilies `{ int `}
	new af_null `{ return 0; `}
	new af_unspec `{ return  AF_UNSPEC; `} 		# unspecified  
	new af_unix `{ return  AF_UNIX; `} 		# local to host (pipes)  
	new af_local `{ return  AF_LOCAL; `} 		# backward compatibility  
	new af_inet `{ return  AF_INET; `}		# internetwork: UDP, TCP, etc.  
	new af_implink `{ return  AF_IMPLINK; `}	# arpanet imp addresses  
	new af_pup `{ return  AF_PUP; `}		# pup protocols: e.g. BSP  
	new af_chaos `{ return  AF_CHAOS; `}		# mit CHAOS protocols  
	new af_ns `{ return  AF_NS; `}			# XEROX NS protocols  
	new af_iso `{ return  AF_ISO; `}		# ISO protocols  
	new af_osi `{ return  AF_OSI; `} 
	new af_ecma `{ return  AF_ECMA; `}		# European computer manufacturers  
	new af_datakit `{ return  AF_DATAKIT; `}	# datakit protocols  
	new af_ccitt `{ return  AF_CCITT; `}		# CCITT protocols, X.25 etc  
	new af_sna `{ return  AF_SNA; `}		# IBM SNA  
	new af_decnet `{ return  AF_DECnet; `}		# DECnet  
	new af_dli `{ return  AF_DLI; `}		# DEC Direct data link interface  
	new af_lat `{ return  AF_LAT; `}		# LAT  
	new af_hylink `{ return  AF_HYLINK; `}		# NSC Hyperchannel  
	new af_route `{ return  AF_ROUTE; `}		# Internal Routing Protocol  
	new af_link `{ return  AF_LINK; `}		# Link layer interface  
	new af_coip `{ return  AF_COIP; `}		# connection-oriented IP, aka ST II  
	new af_cnt `{ return  AF_CNT; `}		# Computer Network Technology  
	new af_ipx `{ return  AF_IPX; `}		# Novell Internet Protocol  
	new af_sip `{ return  AF_SIP; `}		# Simple Internet Protocol  
	new af_isdn `{ return  AF_ISDN; `}		# Integrated Services Digital Network 
	new af_e164 `{ return  AF_E164; `}		# CCITT E.164 recommendation  
	new af_inet6 `{ return  AF_INET6; `}		# IPv6  
	new af_ieee80211 `{ return  AF_IEEE80211; `} 	# IEEE 802.11 protocol  
	new af_max `{ return  AF_MAX; `}
end
extern FFSocketProtocolFamilies `{ int `}
	new pf_null `{ return 0; `}
	new pf_unspec `{ return PF_UNSPEC; `}
	new pf_local `{ return PF_LOCAL; `}
	new pf_unix `{ return PF_UNIX; `}
	new pf_inet `{ return PF_INET; `}
	new pf_implink `{ return PF_IMPLINK; `}
	new pf_pup `{ return PF_PUP; `}
	new pf_chaos `{ return PF_CHAOS; `}
	new pf_ns `{ return PF_NS; `}
	new pf_iso `{ return PF_ISO; `}
	new pf_osi `{ return PF_OSI; `}
	new pf_ecma `{ return PF_ECMA; `}
	new pf_datakit `{ return PF_DATAKIT; `}
	new pf_ccitt `{ return PF_CCITT; `}
	new pf_sna `{ return PF_SNA; `}
	new pf_decnet `{ return PF_DECnet; `}
	new pf_dli `{ return PF_DLI; `}
	new pf_lat `{ return PF_LAT; `}
	new pf_hylink `{ return PF_HYLINK; `}
	new pf_route `{ return PF_ROUTE; `}
	new pf_link `{ return PF_LINK; `}
	new pf_xtp `{ return PF_XTP; `}
	new pf_coip `{ return PF_COIP; `}
	new pf_cnt `{ return PF_CNT; `}
	new pf_sip `{ return PF_SIP; `}
	new pf_ipx `{ return PF_IPX; `}
	new pf_rtip `{ return PF_RTIP; `}
	new pf_pip `{ return PF_PIP; `}
	new pf_isdn `{ return PF_ISDN; `}
	new pf_key `{ return PF_KEY; `}
	new pf_inet6 `{ return PF_INET6; `}
	new pf_natm `{ return PF_NATM; `}
	new pf_max `{ return PF_MAX; `}
end


extern FFSocket `{ FFSocketDescriptor `}
	
	new socket(domain :FFSocketAddressFamilies, socketType :FFSocketTypes, protocol :FFSocketProtocolFamilies) `{
		return socket(domain, socketType, protocol);
	`}	
	fun descriptor:Int `{ return recv; `}

	private fun i_gethostbyname(n: NativeString):FFSocket_Hostent import String::to_cstring `{ return gethostbyname(n); `}
	fun gethostbyname(name: String):FFSocket_Hostent
	do
		var he: nullable FFSocket_Hostent
		he = i_gethostbyname(name.to_cstring)
		return he
	end


	#fun i_connect() `{
	#	connect( recv, 
	#`}
	#fun connect(addrIn: FFSocket_Addr_In, )
	#do
		
	#end
end
