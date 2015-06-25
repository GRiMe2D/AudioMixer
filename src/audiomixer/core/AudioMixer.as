package audiomixer.core
{
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import audiomixer.utils.mergeAudioPackets;

	public class AudioMixer implements IAudioInput
	{
		
		public static const SOUND_LOOP_NUMBER:int = 2048;
		
		private var m_channels:Vector.<MixerChannel>;
		private var bytes:ByteArray;
		private var timer:Timer;
		private var m_master:MixerChannel;
		private var sound:Sound;
		
		public function AudioMixer()
		{
			var i:int;
			
			m_channels = new Vector.<MixerChannel>;
			
			m_master = new MixerChannel();
			
			m_master.preVolume.db = 0;
			m_master.postVolume.db = -6;
			this.add(m_master);
			
			
			bytes = new ByteArray();
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				bytes.writeFloat(0);
				bytes.writeFloat(0);
			}
			
			sound = new Sound();
			sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			sound.play();
			
		}
		
		public function get masterChannel():MixerChannel {
			return m_master;
		}
		
		public function add(mixerSlot:MixerChannel):int {
			return m_channels.push(mixerSlot) - 1;
		}
		
		public function input(packet:AudioPacket):void {
			
		}
		
		private function onSampleData(e:SampleDataEvent):void {
			var channel:MixerChannel;
			var i:int;
			var packets:Vector.<AudioPacket> = new Vector.<AudioPacket>;
			var packet:AudioPacket;
			var signal:AudioSignal;
			
			for each (channel in m_channels) {
				channel.input(new AudioPacket());
				packets.push(channel.output());
			}
			
			packet = mergeAudioPackets(packets);
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				signal = packet.get(i);
				
				signal.r = Math.max(-1, Math.min(1, signal.r));
				signal.l = Math.max(-1, Math.min(1, signal.l));
				
				e.data.writeFloat(signal.l);
				e.data.writeFloat(signal.r);
			}
			
			
		}
	}
}