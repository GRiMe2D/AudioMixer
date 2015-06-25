package audiomixer.core
{
	import flash.events.SampleDataEvent;
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
			
			m_master = new MixerSlot();
			m_master.nextslot = this;
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
		
		public function add(mixerSlot:MixerSlot):int {
			if (!mixerSlot.nextslot) {
				mixerSlot.nextslot = m_master;
			}
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
		
		private function onSampleData(e:SampleDataEvent):void {
			var slot:MixerSlot;
			var i:int;
			
			for each (slot in slots) {
				slot.input(new AudioPacket());
			}
			
			bytes.position = 0;
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				e.data.writeFloat(bytes.readFloat());
				e.data.writeFloat(bytes.readFloat());
			}
			
			
		}
	}
}