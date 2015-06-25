package generators
{
	import audiomixer.core.AudioMixer;
	import audiomixer.core.AudioPacket;
	import audiomixer.core.AudioSignal;
	import audiomixer.core.SignalVolume;
	import audiomixer.core.Effect;
	
	public class WhiteNoise extends Effect
	{
		
		private var m_volume:SignalVolume;
		
		public function WhiteNoise(volume:SignalVolume = null)
		{
			super();
			
			if (volume) {
				m_volume = volume;
			} else {
				m_volume = new SignalVolume();
			}

		}
		
		public function get volume():SignalVolume {
			return m_volume;
		}
		
		public function set volume(to:SignalVolume):void {
			m_volume = to;
		}
		
		override public function input(packet:AudioPacket):void {
			var i:int;
			var signal:AudioSignal;
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				signal = packet.get(i);
				
				
				signal.l = (Math.random() * 2 - 1) * m_volume.amp;
				signal.r = (Math.random() * 2 - 1) * m_volume.amp;
				
				
			}
		}
	}
}