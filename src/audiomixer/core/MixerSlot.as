package audiomixer.core
{
	import audiomixer.utils.amp2db;
	import audiomixer.utils.db2amp;
	import audiomixer.utils.log10;
	
	import generators.WhiteNoise;
	
	public class MixerSlot implements IAudioInput
	{
		
		protected var m_nextslot:IAudioInput;
		protected var m_effects:Vector.<IAudioInput>;
		protected var m_preVolume:SignalVolume;
		protected var m_postVolume:SignalVolume;
		
		public function MixerSlot()
		{
			m_effects = new Vector.<IAudioInput>;
			m_effects.push(new WhiteNoise());
			
			m_preVolume = new SignalVolume();
			m_postVolume = new SignalVolume();
		}
		
		public function set nextslot(to:IAudioInput):void {
			m_nextslot = to;
		}
		
		public function get nextslot():IAudioInput {
			return m_nextslot;
		}
		
		public function input(packet:AudioPacket):void
		{
			workOn(packet);
			out(packet);
		}
		
		protected function workOn(packet:AudioPacket):void {
			var i:int;
			var signal:AudioSignal;
			var effect:IAudioInput;
			
			
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				signal = packet.get(i);
				signal.r *= m_preVolume.amp;
				signal.l *= m_preVolume.amp;
			}
			
			
			for each (effect in m_effects) {
				effect.input(packet);
			}
			
			
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				signal = packet.get(i);
				signal.l *= m_postVolume.amp;
				signal.r *= m_postVolume.amp;
			}
		}
		
		protected function out(packet:AudioPacket):void {
			if (m_nextslot) {
				m_nextslot.input(packet);
			}
		}
		
		public function set preVolume(db:SignalVolume):void {
			m_preVolume = db;
		}
		
		public function get preVolume():SignalVolume {
			return m_preVolume;
		}
		
		public function set postVolume(db:SignalVolume):void {
			m_postVolume = db
		}
		
		public function get postVolume():SignalVolume {
			return m_postVolume;
		}
	}
}