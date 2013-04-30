module socket
import ffsocket

class Socket

	var address: String
	var host: nullable String
	var port: Int
	private var socket: FFSocket
	private var addrin: FFSocketAddrIn

	init streamWithHost(thost: String, tport: Int)
	do
		socket = new FFSocket.socket( new FFSocketAddressFamilies.af_inet, new FFSocketTypes.sock_stream, new FFSocketProtocolFamilies.pf_null )
		var hostname = socket.gethostbyname(thost)
		addrin = new FFSocketAddrIn.withHostent(hostname, tport)
		address = addrin.address
		host = hostname.h_name
		port = addrin.port
	end

	init streamWithPort(tport: Int)
	do
		socket = new FFSocket.socket( new FFSocketAddressFamilies.af_inet, new FFSocketTypes.sock_stream, new FFSocketProtocolFamilies.pf_null )
		addrin = new FFSocketAddrIn.with(tport, new FFSocketAddressFamilies.af_inet)
		address = addrin.address
		port = addrin.port
		host = null
	end

	init primitiveInit(h: FFSocketAcceptResult)
	do
		socket = h.socket
		addrin = h.addrIn
		address = addrin.address
		port = addrin.port
		host = null
	end

	fun connect:Bool do return socket.connect(addrin) >= 0
	fun write(msg: String):Bool do return socket.write(msg) >= 0
	fun read:String do return socket.read
	fun close:Bool do return socket.close >= 0
	fun bind:Bool do return socket.bind(addrin) >= 0
	fun listen(size: Int):Bool do return socket.listen(size) >= 0
	fun accept:Socket do return new Socket.primitiveInit(socket.accept)

	fun errno:Int do return socket.errno
end





class SocketSet
	var sset: FFSocketSet
	init do sset = new FFSocketSet end
	fun set(s: Socket) do sset.set(s.socket) end
	fun isSet(s: Socket):Bool do return sset.isSet(s.socket) end
	fun zero do sset.zero end
	fun clear(s: Socket) do sset.clear(s.socket) end
end
class SocketObserver
	private var observer: FFSocketObserver
	var readset: nullable SocketSet = null
	var writeset: nullable SocketSet = null
	var exceptset: nullable SocketSet = null
	init(read :Bool, write :Bool, except: Bool)
	do
		if read then readset = new SocketSet
		if write then writeset = new SocketSet
		if except then exceptset = new SocketSet
		observer = new FFSocketObserver
	end	
	fun select(max: Socket,seconds: Int, microseconds: Int):Bool
	do
		var timeval = new FFTimeval(seconds, microseconds)
		return observer.select(max.socket, readset.sset, writeset.sset, readset.sset, timeval) > 0
	end
end

