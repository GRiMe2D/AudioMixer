package generators
{
	import audiomixer.core.AudioMixer;
	import audiomixer.core.AudioPacket;
	import audiomixer.core.AudioPlugin;
	import audiomixer.core.AudioSignal;
	import audiomixer.core.SignalVolume;
	
	public class MonoTone extends AudioPlugin
	{
		
		public static const NAME:String = "Mono Tone Generator";
		
		private var m_freq:Number;
		private var m_position:Number;
		private var m_volume:SignalVolume;
		
		public function MonoTone(volume:SignalVolume = null, freq:Number = Number.NaN)
		{
			m_volume = volume || new SignalVolume(-6);
			m_freq = isNaN(freq) ? 440 : freq;
			m_position = 0;
		}
		
		override public function input(packet:AudioPacket):void {
			var i:int;
			var signal:AudioSignal;
			var phase:Number;
			var wave:Number;
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				signal = packet.get(i);
				
				phase = m_position / 44100 * Math.PI * 2;
				m_position++;
				m_position%= 44100;
				wave = Math.sin(phase * m_freq) * m_volume.amp;
				signal.r = wave;
				signal.l = wave;
				
			}
		}
		
		public function get volume():SignalVolume {
			return m_volume;
		}
		
		public function set volume(to:SignalVolume):void {
			m_volume = to;
		}
		
		override public function get name():String {
			return NAME;
		}
		
	}
}