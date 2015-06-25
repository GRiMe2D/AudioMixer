package audiomixer.core
{
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Timer;

	public class AudioMixer implements IAudioInput
	{
		
		public static const SOUND_LOOP_NUMBER:int = 2048;
		
		private var slots:Vector.<MixerSlot>;
		private var bytes:ByteArray;
		private var timer:Timer;
		private var m_master:MixerSlot;
		private var sound:Sound;
		
		public function AudioMixer()
		{
			var i:int;
			
			slots = new Vector.<MixerSlot>;
			
			
			
		}
		
		public function add(mixerSlot:MixerSlot):int {
			return slots.push(mixerSlot) - 1;
		}
		
		public function input(packet:AudioPacket):void {
			var i:int; 
			var signal:AudioSignal;
			
			
			bytes.position = 0;
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				signal = packet.get(i);
				bytes.writeFloat(signal.l);
				bytes.writeFloat(signal.r);
			}
		}
	}
}