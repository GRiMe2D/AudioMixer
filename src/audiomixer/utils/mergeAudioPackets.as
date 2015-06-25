package audiomixer.utils
{
	import audiomixer.core.AudioMixer;
	import audiomixer.core.AudioPacket;
	import audiomixer.core.AudioSignal;

	public function mergeAudioPackets(audioPackets:Vector.<AudioPacket>):AudioPacket {
		var i:int;
		var $packet:AudioPacket;
		var packet:AudioPacket = new AudioPacket();
		var signal:AudioSignal;
		
		for each ($packet in packet) {
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				signal = packet.get(i);
				signal.l += $packet.get(i).l;
				signal.r += $packet.get(i).r;
			}
		}
		
		for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
			signal = packet.get(i);
			signal.r /= audioPackets.length;
			signal.l /= audioPackets.length;
		}
		
		return packet;
	}
}